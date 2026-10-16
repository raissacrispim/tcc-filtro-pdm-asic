#!/usr/bin/env python3
# Controle negativo: copia o SDF trocando o hold de D de UMA
# instancia por 50 ns. uso: hold_inflado.py entrada.sdf saida.sdf instancia
import re, sys
ent, sai, inst = sys.argv[1:4]
linhas = open(ent).read().split('\n')
dentro, n = False, 0
for i, l in enumerate(linhas):
    if '(INSTANCE' in l:
        dentro = l.split('(INSTANCE', 1)[1].strip(' )').replace('\\', '') == inst
    if dentro and ('SETUPHOLD' in l or '(HOLD' in l) and re.search(r'\bD\b', l):
        novo = re.sub(r'\([^()]*\)(\)+)\s*$', r'(50.000::50.000)\1', l)
        print('antes :', l.strip()); print('depois:', novo.strip())
        linhas[i] = novo; n += 1
open(sai, 'w').write('\n'.join(linhas))
print(f'{n} verificacoes de hold alteradas em {inst}')
sys.exit(0 if n else 1)
