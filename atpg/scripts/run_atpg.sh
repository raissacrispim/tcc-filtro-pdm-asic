#!/bin/bash

# ============================================================
# Execucao do ATPG (TestMAX ATPG)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio):
#
#   atpg/scripts/run_atpg.sh              # stuck-at
#   atpg/scripts/run_atpg.sh transition   # transition
#
# O tmax exige SYNOPSYS apontando para a instalacao do
# TestMAX. A variavel e alterada apenas neste script, sem
# afetar o Design Compiler e o Fusion Compiler no terminal.
# ============================================================

set -e

MODELO=${1:-stuck}

TESTMAX_HOME=/Tools/synopsys/testmax/X-2025.06-SP2

cd "$(dirname "$0")/../.."

mkdir -p atpg/reports atpg/output

export SYNOPSYS=$TESTMAX_HOME
export PATH=$SYNOPSYS/bin:$PATH

tmax -shell "atpg/scripts/atpg_${MODELO}.tcl" \
    2>&1 | tee "atpg/reports/tmax_${MODELO}_terminal.log"

echo
grep -iE "test coverage|fault coverage|total patterns|pattern count" \
    "atpg/reports/${MODELO}_summary.rpt" 2>/dev/null \
    || echo "Resumo nao encontrado: verifique o log acima."
