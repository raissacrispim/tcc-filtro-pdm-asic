#!/usr/bin/env python3
# Compara dois SDF arco a arco (IOPATH), ignorando linhas
# repetidas, bordas (posedge/negedge) e escape de nomes.
# Uso: compara_sdf.py A.sdf B.sdf
import re, sys, collections, statistics

TOK = re.compile(r'\(|\)|"[^"]*"|[^\s()]+')
ESCALA = {'1ns': 1000.0, '100ps': 100.0, '10ps': 10.0, '1ps': 1.0}


def arvore(caminho):
    pilha = [[]]
    with open(caminho) as f:
        for linha in f:
            for t in TOK.findall(linha.split('//')[0]):
                if t == '(':
                    pilha.append([])
                elif t == ')':
                    e = pilha.pop()
                    pilha[-1].append(e)
                else:
                    pilha[-1].append(t)
    return pilha[0][0]


def pino(x):
    if isinstance(x, list):
        x = x[-1]
    return x.replace('\\', '')


def vmax(v):
    # (min:typ:max) -> max, valor usado pelo VCS com -sdf max
    if not v:
        return None
    c = v[0].split(':')
    return float(c[-1] if c[-1] != '' else c[0])


def le(caminho):
    esc, arcos, tipo, n = 1000.0, collections.defaultdict(list), {}, 0
    for e in arvore(caminho):
        if not isinstance(e, list) or not e:
            continue
        if e[0] == 'TIMESCALE':
            esc = ESCALA[''.join(e[1:]).replace(' ', '')]
        if e[0] != 'CELL':
            continue
        inst = ct = None
        for s in e[1:]:
            if s[0] == 'CELLTYPE':
                ct = s[1].strip('"')
            elif s[0] == 'INSTANCE':
                inst = pino(s[1]) if len(s) > 1 else ''
            elif s[0] == 'DELAY':
                for bloco in s[1:]:
                    for it in bloco[1:]:
                        if it[0] in ('COND', 'CONDELSE'):
                            it = it[-1]
                        if it[0] != 'IOPATH':
                            continue
                        n += 1
                        vals = [vmax(v) for v in it[3:] if isinstance(v, list)]
                        arcos[(inst, pino(it[1]), pino(it[2]))].extend(
                            x * esc for x in vals if x is not None)
                        tipo[inst] = ct
    return arcos, tipo, n


A, tA, nA = le(sys.argv[1])
B, tB, nB = le(sys.argv[2])
print(f'A: linhas IOPATH={nA}  arcos unicos={len(A)}')
print(f'B: linhas IOPATH={nB}  arcos unicos={len(B)}')
soA, soB = set(A) - set(B), set(B) - set(A)
print(f'arcos so em A: {len(soA)}   so em B: {len(soB)}')
for k in sorted(soA)[:10]:
    print('  so A:', tA.get(k[0]), k)
for k in sorted(soB)[:10]:
    print('  so B:', tB.get(k[0]), k)


def dif(filtro, titulo):
    d = sorted(max(B[k]) - max(A[k]) for k in set(A) & set(B)
               if A[k] and B[k] and filtro(k))
    if not d:
        print(f'{titulo}: nenhum arco')
        return
    print(f'{titulo}: n={len(d)}  dif B-A (ps) min={d[0]:.1f} '
          f'mediana={statistics.median(d):.1f} max={d[-1]:.1f}  '
          f'|dif|>10ps: {sum(abs(x) > 10 for x in d)}')


dif(lambda k: True, 'todos os arcos')
dif(lambda k: k[1] == 'CLK', 'CLK->Q (flip-flops)')
dif(lambda k: 'CTS' in k[0], 'celulas da arvore de clock (CTS)')
k = ('u_cic_u_integradores_int3_reg_0_', 'CLK', 'Q')
print('exemplo', k, 'A =', A.get(k), ' B =', B.get(k))
