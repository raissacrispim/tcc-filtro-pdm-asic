#!/bin/bash
# ============================================================
# STA de diagnostico (somente leitura) - ver sta_modos.tcl
#
# Uso (raiz do repositorio):
#   sta/diagnostico/run_diagnostico.sh              # todos os casos
#   sta/diagnostico/run_diagnostico.sh ff0p95vn40c  # um corner
#   MODOS=todos REFS=porta sta/diagnostico/run_diagnostico.sh ff0p95vn40c
#
# Resumo: sta/diagnostico/reports/resumo.txt
# ============================================================
cd "$(dirname "$0")/../.."
command -v pt_shell > /dev/null || {
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"; exit 1; }

declare -A SPEF=(
    [tt0p85v25c]=pnr/output/filtro_pdm.Cmax_25.spef
    [ss0p75v125c]=pnr/output/filtro_pdm.Cmax_25.spef
    [ff0p95vn40c]=pnr/output/filtro_pdm.Cmin_25.spef
)
CORNERS=${1:-"tt0p85v25c ss0p75v125c ff0p95vn40c"}
mkdir -p sta/diagnostico/reports
RES=sta/diagnostico/reports/resumo.txt
: > $RES
for C in $CORNERS; do
  for M in ${MODOS:-func shift todos}; do
    for R in ${REFS:-porta real fc}; do
      D=sta/diagnostico/reports/${C}_${M}_${R}
      mkdir -p $D
      STA_CORNER=$C STA_SPEF=${SPEF[$C]} STA_MODO=$M STA_REF=$R \
        pt_shell -f sta/diagnostico/sta_modos.tcl > $D/pt_shell.log 2>&1
      grep -h '^LATENCIA_REAL' $D/pt_shell.log | head -1 >> $RES
      grep -h '^RESUMO' $D/pt_shell.log >> $RES
      grep -hE '^Error' $D/pt_shell.log | sort | uniq -c | sed "s|^|ERRO $C $M $R: |" >> $RES
      echo >> $RES
    done
  done
done
cat $RES
