#!/usr/bin/env python3
# ============================================================
# expand_cdl_m.py
# Expande o multiplicador m=N dos transistores de um CDL
# Projeto: Filtro PDM CIC + FIR
#
# Uso:
#
#   python3 verif/scripts/expand_cdl_m.py <entrada.cdl> <saida.cdl>
#
# O CDL das standard cells do SAED32 descreve transistores em
# paralelo com um multiplicador, por exemplo:
#
#   MN Y A VSS VSS n105 w=0.42u l=0.03u nf=1 m=4
#
# No layout, o IC Validator extrai 4 transistores e os agrupa
# em paralelo (W = 4 x 0,42 um, NF = 4). Do lado do esquematico
# o m=4 nao e expandido, gerando "property mismatch" no LVS.
#
# Este script substitui cada transistor com m=N por N copias
# (MN_m1 ... MN_mN) com m=1, de modo que os dois lados sejam
# agrupados da mesma forma pelo merge_parallel do runset.
# ============================================================

import re
import sys

PARAM_M = re.compile(r"(?i)(^|\s)m\s*=\s*(\d+)(?=\s|$)")


def linhas_logicas(texto):
    """Junta linhas de continuacao ('+') a linha anterior."""
    resultado = []
    for linha in texto.splitlines():
        if linha.startswith("+") and resultado:
            resultado[-1] = resultado[-1].rstrip() + " " + linha[1:].strip()
        else:
            resultado.append(linha)
    return resultado


def expandir(entrada, saida):
    with open(entrada, encoding="latin-1") as f:
        linhas = linhas_logicas(f.read())

    expandidos = 0
    novos = 0
    saida_linhas = []

    for linha in linhas:
        texto = linha.strip()
        achado = PARAM_M.search(texto)

        if texto[:1].upper() == "M" and achado and int(achado.group(2)) > 1:
            n = int(achado.group(2))
            nome, resto = texto.split(None, 1)
            resto_m1 = PARAM_M.sub(lambda g: f"{g.group(1)}m=1", resto, count=1)
            for i in range(1, n + 1):
                saida_linhas.append(f"{nome}_m{i} {resto_m1}")
            expandidos += 1
            novos += n
        else:
            saida_linhas.append(linha)

    with open(saida, "w", encoding="latin-1") as f:
        f.write("\n".join(saida_linhas) + "\n")

    print(f"Transistores com m>1 expandidos: {expandidos}")
    print(f"Transistores gerados           : {novos}")
    print(f"CDL gerado: {saida}")


def main():
    if len(sys.argv) != 3:
        print("Uso: expand_cdl_m.py <entrada.cdl> <saida.cdl>")
        sys.exit(2)
    expandir(sys.argv[1], sys.argv[2])


if __name__ == "__main__":
    main()
