#!/bin/bash

# ============================================================
# Execucao do ATPG (TestMAX ATPG)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio):
#
#   atpg/scripts/run_atpg.sh              # stuck-at
#   atpg/scripts/run_atpg.sh transition   # transition
#   atpg/scripts/run_atpg.sh stuck pnr    # netlist pos-layout
#   atpg/scripts/run_atpg.sh transition pnr
#
# Com "pnr", relatorios e vetores vao para atpg/reports/pnr/
# e atpg/output/pnr/, sem sobrescrever os da sintese.
#
# No servidor, o tmax (testmax/<versao>/bin, ja no PATH pelo
# snps.sh) exige SYNOPSYS apontando para uma instalacao com a
# pasta auxx/, que existe na instalacao do Design Compiler.
# A variavel e alterada apenas neste script, sem afetar as
# demais ferramentas no terminal.
# ============================================================

set -e
# Sem pipefail, o codigo de saida de 'tmax ... | tee' seria o do
# tee e um erro do TestMAX passaria despercebido
set -o pipefail

MODELO=${1:-stuck}
ETAPA=${2:-synth}

SYN_HOME=${SYN_HOMEDIR:-/Tools/synopsys/syn/X-2025.06-SP2}

cd "$(dirname "$0")/../.."

if [ "$ETAPA" = "pnr" ]; then
    REP=atpg/reports/pnr
else
    REP=atpg/reports
fi

mkdir -p "$REP" atpg/output

export SYNOPSYS=$SYN_HOME

# O transition usa uma copia do SPF do DC com "scan_en" = 0 no
# test_setup (aviso V14); o SPF original nao e alterado
if [ "$MODELO" = "transition" ]; then
    mkdir -p atpg/spf
    python3 atpg/scripts/gera_spf_transition.py \
        synth/netlist/filtro_pdm_syn.spf atpg/spf/filtro_pdm_transition.spf
fi
export ATPG_ETAPA=$ETAPA

tmax -shell "atpg/scripts/atpg_${MODELO}.tcl" \
    2>&1 | tee "$REP/tmax_${MODELO}_terminal.log"

echo
# O TestMAX pode terminar com codigo 0 mesmo apos um erro de
# comando no script: o log e conferido explicitamente
if grep -qE "^ *Error:" "$REP/tmax_${MODELO}_terminal.log"; then
    echo "ATPG REPROVADO: erros no log:"
    grep -E "^ *Error:" "$REP/tmax_${MODELO}_terminal.log" | sort | uniq -c | head
    exit 1
fi
if ! grep -q "script executado ate o final" "$REP/tmax_${MODELO}_terminal.log"; then
    echo "ATPG REPROVADO: o script do TestMAX nao chegou ao fim"
    exit 1
fi
if [ ! -s "$REP/${MODELO}_summary.rpt" ]; then
    echo "ATPG REPROVADO: resumo $REP/${MODELO}_summary.rpt nao gerado"
    exit 1
fi
grep -iE "test coverage|fault coverage|total patterns|pattern count" \
    "$REP/${MODELO}_summary.rpt"
