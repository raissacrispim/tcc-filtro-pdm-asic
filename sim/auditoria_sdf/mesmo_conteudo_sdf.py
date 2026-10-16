#!/usr/bin/env python3
# Verifica se dois SDF tem o mesmo conteudo independentemente da
# ordem dos blocos CELL (o PrimeTime pode escreve-los em ordem
# diferente a cada execucao). O cabecalho e comparado sem DATE.
# Uso: mesmo_conteudo_sdf.py A.sdf B.sdf
import re, sys
from collections import Counter

def le(caminho):
    texto = open(caminho).read()
    partes = re.split(r'\n\s*\(CELL\s*\n', texto)
    cabecalho = [l for l in partes[0].splitlines() if 'DATE' not in l]
    # ultimo bloco carrega o ')' que fecha o DELAYFILE
    partes[-1] = partes[-1].rstrip().rstrip(')').rstrip()
    blocos = Counter(re.sub(r'\s+', ' ', p.strip().rstrip(')').strip())
                     for p in partes[1:])
    return cabecalho, blocos

ca, ba = le(sys.argv[1])
cb, bb = le(sys.argv[2])
print(f'blocos CELL: A={sum(ba.values())}  B={sum(bb.values())}')
so_a, so_b = ba - bb, bb - ba
print(f'blocos so em A: {sum(so_a.values())}   so em B: {sum(so_b.values())}')
for b in list(so_a)[:3]:
    print('  so A:', b[:160])
for b in list(so_b)[:3]:
    print('  so B:', b[:160])
print('cabecalho (sem DATE):', 'igual' if ca == cb else 'DIFERENTE')
ok = not so_a and not so_b and ca == cb
print('CONTEUDO IDENTICO' if ok else 'CONTEUDO DIFERENTE')
sys.exit(0 if ok else 1)
