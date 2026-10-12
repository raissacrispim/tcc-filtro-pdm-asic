#!/usr/bin/env python3
# ============================================================
# fix_gds_pin_text.py
# Move os textos de pino da celula de topo para as camadas de
# pino (PIN) do SAED32
# Projeto: Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio):
#
#   python3 pnr/scripts/fix_gds_pin_text.py \
#       pnr/output/filtro_pdm.gds pnr/output/filtro_pdm_final.gds
#
# O write_gds do Fusion Compiler grava os nomes das portas na
# camada de desenho do metal (ex.: M3 = 15). O runset de LVS do
# SAED32 so reconhece nomes de porta nas camadas de pino
# (M1PIN = 31 ... M9PIN = 39); sem isso, o LVS acusa
# "untexted layout ports".
#
# Somente registros TEXT da celula de topo sao alterados.
# Nenhum poligono e modificado, portanto o DRC nao muda.
# ============================================================

import struct
import sys

BGNSTR, STRNAME, ENDSTR = 0x05, 0x06, 0x07
TEXT, LAYER, ENDEL, ENDLIB = 0x0C, 0x0D, 0x11, 0x04

# Camada de desenho do metal -> camada de pino (SAED32 1P9M)
DESENHO_PARA_PINO = {
    11: 31,  # M1
    13: 32,  # M2
    15: 33,  # M3
    17: 34,  # M4
    19: 35,  # M5
    21: 36,  # M6
    23: 37,  # M7
    25: 38,  # M8
    27: 39,  # M9
}


def corrigir(entrada, saida, topo):
    with open(entrada, "rb") as f:
        dados = bytearray(f.read())

    pos = 0
    celula = None
    em_texto = False
    alterados = {}

    while pos + 4 <= len(dados):
        tamanho, tipo, _ = struct.unpack(">HBB", dados[pos:pos + 4])
        if tamanho < 4:
            break
        conteudo = dados[pos + 4:pos + tamanho]

        if tipo == STRNAME:
            celula = bytes(conteudo).rstrip(b"\0").decode("ascii", "replace")
        elif tipo == ENDSTR:
            celula = None
        elif tipo == TEXT:
            em_texto = True
        elif tipo == ENDEL:
            em_texto = False
        elif tipo == LAYER and em_texto and celula == topo:
            camada = struct.unpack(">h", conteudo[:2])[0]
            if camada in DESENHO_PARA_PINO:
                nova = DESENHO_PARA_PINO[camada]
                dados[pos + 4:pos + 6] = struct.pack(">h", nova)
                chave = (camada, nova)
                alterados[chave] = alterados.get(chave, 0) + 1
        elif tipo == ENDLIB:
            break

        pos += tamanho

    with open(saida, "wb") as f:
        f.write(dados)

    total = sum(alterados.values())
    print(f"Celula de topo : {topo}")
    for (antiga, nova), n in sorted(alterados.items()):
        print(f"  textos {antiga} -> {nova}: {n}")
    print(f"Total de textos movidos: {total}")
    print(f"GDS gerado: {saida}")

    return total


def main():
    if len(sys.argv) not in (3, 4):
        print("Uso: fix_gds_pin_text.py <entrada.gds> <saida.gds> [celula_topo]")
        sys.exit(2)

    topo = sys.argv[3] if len(sys.argv) == 4 else "filtro_pdm"

    if corrigir(sys.argv[1], sys.argv[2], topo) == 0:
        print("AVISO: nenhum texto de pino foi encontrado/alterado.")
        sys.exit(1)


if __name__ == "__main__":
    main()
