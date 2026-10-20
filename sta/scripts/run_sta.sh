#!/bin/bash

# ============================================================
# Analise de timing pos-layout (signoff) em varios corners e
# modos (PrimeTime)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio, apos finish.tcl):
#
#   sta/scripts/run_sta.sh
#
# Corners da biblioteca SAED32 (PVT):
#   tt0p85v25c  tipico   (0,85 V, 25 C)   Cmax
#   ss0p75v125c lento    (0,75 V, 125 C)  Cmax  - pior caso de setup
#   ff0p95vn40c rapido   (0,95 V, -40 C)  Cmin  - pior caso de hold
#
# Modos:
#   func  operacao normal (scan_en = 0)
#   scan  cadeia de scan e transicoes de scan_en
#
# Criterio de aprovacao: 0 endpoints com setup ou hold violado
# em todos os corners e modos (incerteza do SDC, sem alteracao).
# ============================================================

set -e

DB_DIR=/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm

cd "$(dirname "$0")/../.."

if ! command -v pt_shell > /dev/null; then
    echo "ERRO: pt_shell (PrimeTime) nao encontrado no PATH."
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"
    exit 1
fi

CORNERS=(
    "tt0p85v25c  pnr/output/filtro_pdm.Cmax_25.spef"
    "ss0p75v125c pnr/output/filtro_pdm.Cmax_25.spef"
    "ff0p95vn40c pnr/output/filtro_pdm.Cmin_25.spef"
)
MODOS=(func scan)

mkdir -p sta/reports
FALHAS=0

for ITEM in "${CORNERS[@]}"; do

    read -r CORNER SPEF <<< "$ITEM"

    if [ ! -f "$DB_DIR/saed32rvt_${CORNER}.db" ]; then
        echo "ERRO: biblioteca saed32rvt_${CORNER}.db nao encontrada."
        exit 1
    fi
    if [ ! -f "$SPEF" ]; then
        echo "ERRO: $SPEF nao encontrado. Execute finish.tcl."
        exit 1
    fi

    for MODO in "${MODOS[@]}"; do

        REP="sta/reports/${CORNER}_${MODO}"
        mkdir -p "$REP"

        STA_CORNER=$CORNER STA_SPEF=$SPEF STA_MODO=$MODO \
            pt_shell -f sta/scripts/sta_corner.tcl \
            > "$REP/pt_shell.log" 2>&1 || true

        sed -n '/^======/,/^======/p' "$REP/pt_shell.log"

        if ! grep -q "Endpoints com hold violado : 0" "$REP/pt_shell.log" ||
           ! grep -q "Endpoints com setup violado: 0" "$REP/pt_shell.log"; then
            echo "REPROVADO: $CORNER / $MODO (veja $REP/)"
            FALHAS=$((FALHAS + 1))
        fi
        grep -E '^Error' "$REP/pt_shell.log" | sort | uniq -c || true

    done
done

echo
if [ "$FALHAS" -eq 0 ]; then
    echo "STA APROVADA: 0 violacoes de setup e hold em 3 corners x 2 modos"
else
    echo "STA REPROVADA: $FALHAS combinacoes corner/modo com violacoes"
    exit 1
fi
