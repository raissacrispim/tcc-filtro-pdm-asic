#!/usr/bin/env python3
"""SPF do ATPG transition derivado do SPF gerado pelo Design Compiler.

Uso: gera_spf_transition.py <spf_do_dc> <spf_saida>

O ATPG transition restringe scan_en = 0 fora do shift
(add_pi_constraints, aviso M487). O SPF do DC foi gerado antes
dessa restricao: o procedimento "test_setup" termina com um
vetor vazio (V { }) e deixa scan_en em N, oposto ao valor
restrito (aviso V14 do TestMAX). Esta copia acrescenta apenas
"scan_en" = 0 a esse vetor; o resto do arquivo e identico ao
original, que nao e alterado.
"""
import re
import sys

ent, sai = sys.argv[1], sys.argv[2]
txt = open(ent).read()

ini = txt.find('"test_setup" {')
if ini < 0:
    sys.exit('ERRO: procedimento "test_setup" nao encontrado em ' + ent)

# Vetor vazio dentro do test_setup
vazio = re.compile(r'V \{\s*\}')
m = vazio.search(txt, ini)
fim_bloco = txt.find('\n    }', ini)
if not m or m.start() > fim_bloco:
    sys.exit('ERRO: vetor vazio "V { }" nao encontrado no test_setup')

novo = 'V {\n            "scan_en" = 0;\n        }'
saida = txt[:m.start()] + novo + txt[m.end():]
open(sai, 'w').write(saida)
print(f'SPF do transition: {sai} (test_setup com "scan_en" = 0)')
