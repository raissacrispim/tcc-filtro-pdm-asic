#!/usr/bin/env python3
# ============================================================
# check_gds.py
# Verificacao basica de um arquivo GDSII
# Projeto: Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio):
#
#   python3 pnr/scripts/check_gds.py pnr/output/filtro_pdm.gds
#
# Le o GDSII sem bibliotecas externas e informa:
#   - celula de topo (nao referenciada por nenhuma outra)
#   - numero de celulas, poligonos, referencias e textos
#   - camadas GDS utilizadas
#   - celulas referenciadas que estao vazias ou ausentes
#     (indicaria falha na mesclagem do GDS das standard cells)
# ============================================================

import struct
import sys
from collections import defaultdict

HEADER, BGNLIB, LIBNAME, UNITS, ENDLIB = 0x00, 0x01, 0x02, 0x03, 0x04
BGNSTR, STRNAME, ENDSTR = 0x05, 0x06, 0x07
BOUNDARY, PATH, SREF, AREF, TEXT = 0x08, 0x09, 0x0A, 0x0B, 0x0C
LAYER, SNAME, STRING, ENDEL = 0x0D, 0x12, 0x19, 0x11


def ler_registros(caminho):
    with open(caminho, "rb") as f:
        dados = f.read()
    pos = 0
    while pos + 4 <= len(dados):
        tamanho, tipo, _ = struct.unpack(">HBB", dados[pos:pos + 4])
        if tamanho < 4:
            break
        yield tipo, dados[pos + 4:pos + tamanho]
        pos += tamanho
        if tipo == ENDLIB:
            break


def texto(conteudo):
    return conteudo.rstrip(b"\0").decode("ascii", "replace")


def analisar(caminho):
    celulas = {}
    atual = None
    elemento = None
    biblioteca = ""

    for tipo, conteudo in ler_registros(caminho):
        if tipo == LIBNAME:
            biblioteca = texto(conteudo)
        elif tipo == STRNAME:
            atual = texto(conteudo)
            celulas[atual] = {
                "poligonos": 0, "textos": 0,
                "refs": defaultdict(int), "camadas": set(),
            }
        elif tipo == ENDSTR:
            atual = None
        elif atual is None:
            continue
        elif tipo in (BOUNDARY, PATH):
            elemento = "geo"
            celulas[atual]["poligonos"] += 1
        elif tipo in (SREF, AREF):
            elemento = "ref"
        elif tipo == TEXT:
            elemento = "txt"
            celulas[atual]["textos"] += 1
        elif tipo == LAYER and elemento in ("geo", "txt"):
            celulas[atual]["camadas"].add(struct.unpack(">h", conteudo[:2])[0])
        elif tipo == SNAME and elemento == "ref":
            celulas[atual]["refs"][texto(conteudo)] += 1
        elif tipo == ENDEL:
            elemento = None

    return biblioteca, celulas


def main():
    if len(sys.argv) != 2:
        print("Uso: python3 pnr/scripts/check_gds.py <arquivo.gds>")
        sys.exit(2)

    biblioteca, celulas = analisar(sys.argv[1])

    referenciadas = set()
    for c in celulas.values():
        referenciadas.update(c["refs"])

    topos = sorted(set(celulas) - referenciadas)
    ausentes = sorted(referenciadas - set(celulas))
    vazias = sorted(
        nome for nome, c in celulas.items()
        if c["poligonos"] == 0 and not c["refs"]
    )

    camadas = set()
    for c in celulas.values():
        camadas |= c["camadas"]

    print(f"Arquivo        : {sys.argv[1]}")
    print(f"Biblioteca     : {biblioteca}")
    print(f"Celulas        : {len(celulas)}")
    print(f"Topo           : {', '.join(topos) if topos else '(nenhum)'}")
    print(f"Camadas GDS    : {sorted(camadas)}")

    for topo in topos:
        c = celulas[topo]
        print()
        print(f"Celula de topo '{topo}':")
        print(f"  poligonos/caminhos : {c['poligonos']}")
        print(f"  textos (pinos)     : {c['textos']}")
        print(f"  instancias         : {sum(c['refs'].values())}")
        print(f"  tipos de celula    : {len(c['refs'])}")

    print()
    print(f"Celulas referenciadas e ausentes do arquivo : {len(ausentes)}")
    for nome in ausentes[:20]:
        print(f"  - {nome}")
    print(f"Celulas sem nenhuma geometria               : {len(vazias)}")
    for nome in vazias[:20]:
        print(f"  - {nome}")

    print()
    if ausentes or vazias:
        print("RESULTADO: GDS INCOMPLETO (falha na mesclagem das standard cells)")
        sys.exit(1)
    print("RESULTADO: GDS completo (todas as celulas possuem geometria)")


if __name__ == "__main__":
    main()
