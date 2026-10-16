#!/bin/bash

# ============================================================
# Geracao do SDF da simulacao pos-layout (PrimeTime)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio, apos finish.tcl):
#
#   sta/scripts/run_sdf_gls.sh
#   SDF_SAIDAS=1 sta/scripts/run_sdf_gls.sh   # inclui as portas de saida
#
# Gera pnr/output/filtro_pdm_pnr_pt.sdf, usado por
# sim/scripts/compile_gls.sh pnr sdf. Motivo: docs/auditoria_sdf.md
# ============================================================

set -e

cd "$(dirname "$0")/../.."

if ! command -v pt_shell > /dev/null; then
    echo "ERRO: pt_shell (PrimeTime) nao encontrado no PATH."
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"
    exit 1
fi

SDF=pnr/output/filtro_pdm_pnr_pt.sdf
LOG=sta/reports/sdf_gls/pt_shell.log
mkdir -p sta/reports/sdf_gls
rm -f "$SDF"

pt_shell -f sta/scripts/write_sdf_gls.tcl > "$LOG" 2>&1 || true

if [ ! -s "$SDF" ]; then
    echo "ERRO: $SDF nao foi gerado. Veja $LOG"
    exit 1
fi

echo "Mensagens do PrimeTime:"
grep -E '^(Error|Warning)' "$LOG" | sort | uniq -c

echo "Conferencia do SDF:"
echo "  CELL            : $(grep -c '(CELLTYPE' "$SDF")"
echo "  IOPATH          : $(grep -c '(IOPATH' "$SDF")"
echo "  SETUPHOLD       : $(grep -c '(SETUPHOLD' "$SDF")"
echo "  WIDTH           : $(grep -c '(WIDTH' "$SDF")"
echo "  INTERCONNECT    : $(grep -c '(INTERCONNECT' "$SDF")"
ESC=$(grep -c '\\\[' "$SDF" || true)
echo "  nomes escapados : $ESC"

if [ "$ESC" -ne 0 ]; then
    echo "ERRO: o SDF contem nomes com colchetes escapados."
    exit 1
fi

echo "SDF gerado: $SDF"
