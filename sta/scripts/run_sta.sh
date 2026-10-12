#!/bin/bash

# ============================================================
# Analise de timing pos-layout em varios corners (PrimeTime)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio, apos finish.tcl):
#
#   sta/scripts/run_sta.sh        # analise nos 3 corners
#   sta/scripts/run_sta.sh eco    # gera ECO de hold no corner ff
#
# O P&R foi otimizado somente no corner tipico. Aqui o mesmo
# layout e verificado nos extremos de processo, tensao e
# temperatura (PVT) da biblioteca SAED32:
#
#   tt0p85v25c  tipico   (0,85 V, 25 C)   - referencia do fluxo
#   ss0p75v125c lento    (0,75 V, 125 C)  - pior caso de setup
#   ff0p95vn40c rapido   (0,95 V, -40 C)  - pior caso de hold
#
# Parasitas: Cmax no tipico e no lento; Cmin no rapido.
# ============================================================

set -e

MODO=${1:-analise}

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

mkdir -p sta/reports

for ITEM in "${CORNERS[@]}"; do

    read -r CORNER SPEF <<< "$ITEM"

    if [ ! -f "$DB_DIR/saed32rvt_${CORNER}.db" ]; then
        echo "ERRO: biblioteca saed32rvt_${CORNER}.db nao encontrada."
        echo "Corners disponiveis:"
        ls "$DB_DIR" | grep '^saed32rvt_.*\.db$'
        exit 1
    fi

    if [ ! -f "$SPEF" ]; then
        echo "ERRO: $SPEF nao encontrado. Execute finish.tcl."
        exit 1
    fi

    mkdir -p "sta/reports/$CORNER"

    # ECO de hold somente no corner rapido (pior caso de hold)
    ECO=0
    if [ "$MODO" = "eco" ]; then
        [ "$CORNER" = "ff0p95vn40c" ] || continue
        ECO=1
    fi

    STA_CORNER=$CORNER STA_SPEF=$SPEF STA_ECO=$ECO \
        pt_shell -f sta/scripts/sta_corner.tcl \
        > "sta/reports/$CORNER/pt_shell.log" 2>&1 || true

    sed -n '/^======/,/^======/p' "sta/reports/$CORNER/pt_shell.log"

    if ! grep -q "Pior setup" "sta/reports/$CORNER/pt_shell.log"; then
        echo "ERRO no corner $CORNER: veja sta/reports/$CORNER/pt_shell.log"
    fi

done
