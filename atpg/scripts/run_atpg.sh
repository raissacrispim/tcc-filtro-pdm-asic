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
# No servidor, o tmax (testmax/<versao>/bin, ja no PATH pelo
# snps.sh) exige SYNOPSYS apontando para uma instalacao com a
# pasta auxx/, que existe na instalacao do Design Compiler.
# A variavel e alterada apenas neste script, sem afetar as
# demais ferramentas no terminal.
# ============================================================

set -e

MODELO=${1:-stuck}

SYN_HOME=${SYN_HOMEDIR:-/Tools/synopsys/syn/X-2025.06-SP2}

cd "$(dirname "$0")/../.."

mkdir -p atpg/reports atpg/output

export SYNOPSYS=$SYN_HOME

tmax -shell "atpg/scripts/atpg_${MODELO}.tcl" \
    2>&1 | tee "atpg/reports/tmax_${MODELO}_terminal.log"

echo
grep -iE "test coverage|fault coverage|total patterns|pattern count" \
    "atpg/reports/${MODELO}_summary.rpt" 2>/dev/null \
    || echo "Resumo nao encontrado: verifique o log acima."
