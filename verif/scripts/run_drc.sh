#!/bin/bash

# ============================================================
# DRC (Design Rule Check) com o IC Validator
# Filtro PDM CIC + FIR - SAED32 1P9M
#
# Uso (a partir da raiz do repositorio):
#
#   verif/scripts/run_drc.sh
#
# Entrada: pnr/output/filtro_pdm_final.gds (gerado por finish.tcl:
#          GDS do FC com as etiquetas das portas nas camadas de
#          pino, via pnr/scripts/fix_gds_pin_text.py)
# Saida:   verif/reports/drc/  (resumo e lista de violacoes)
#          verif/run_drc/      (arquivos de execucao, ignorados
#                               pelo git)
# ============================================================

set -e
# Sem pipefail, o codigo de saida de 'icv ... | tee' seria o do tee
set -o pipefail

PDK_TECH=/Tools/PDK/SAED32/EDK_Digital/tech
RUNSET=$PDK_TECH/icv_drc/saed32nm_1p9m_drc_rules.rs
TOPO=filtro_pdm

RAIZ="$(cd "$(dirname "$0")/../.." && pwd)"
# GDS final (textos de porta nas camadas de pino), gerado por
# finish.tcl via pnr/scripts/fix_gds_pin_text.py
GDS=$RAIZ/pnr/output/${TOPO}_final.gds

if [ ! -f "$GDS" ]; then
    echo "ERRO: GDS nao encontrado: $GDS"
    echo "Execute antes: fc_shell -f pnr/scripts/finish.tcl"
    exit 1
fi

rm -rf "$RAIZ/verif/run_drc"
mkdir -p "$RAIZ/verif/run_drc" "$RAIZ/verif/reports/drc"
cd "$RAIZ/verif/run_drc"

icv -i "$GDS" -c $TOPO -f GDSII \
    -I "$PDK_TECH/icv_drc" \
    "$RUNSET" \
    2>&1 | tee icv_drc.log

for arq in $TOPO.RESULTS $TOPO.LAYOUT_ERRORS icv_drc.log; do
    [ -f "$arq" ] && cp "$arq" "$RAIZ/verif/reports/drc/"
done

echo
echo "============================================"
echo "RESUMO DO DRC"
echo "============================================"
grep -iE "clean|violation|error" "$TOPO.RESULTS" 2>/dev/null | head -20 \
    || echo "Arquivo $TOPO.RESULTS nao encontrado: verifique icv_drc.log"
echo
echo "Relatorios em verif/reports/drc/"

# Criterio de aprovacao: 0 violacoes no resumo do IC Validator
if grep -qE "There are 0 total violations|DRC.*CLEAN" icv_drc.log "$TOPO.RESULTS" 2>/dev/null &&
   ! grep -qE "There are [1-9][0-9]* total violations" icv_drc.log "$TOPO.RESULTS" 2>/dev/null; then
    echo "DRC APROVADO: 0 violacoes"
else
    echo "DRC REPROVADO: veja verif/reports/drc/$TOPO.LAYOUT_ERRORS"
    exit 1
fi
