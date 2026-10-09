#!/bin/bash

# ============================================================
# Simulacao dos vetores de teste do ATPG (VCS)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio, apos atpg_stuck.tcl):
#
#   sim/scripts/sim_atpg.sh
#
# Simula a netlist com scan aplicando os vetores stuck-at
# gerados pelo TestMAX ATPG (testbench criado pelo
# write_testbench). O resultado esperado e 0 erros.
# ============================================================

set -e

SAED32_V=/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v
NETLIST=${1:-synth/netlist/filtro_pdm_syn.v}

RAIZ="$(cd "$(dirname "$0")/../.." && pwd)"

cd "$RAIZ/atpg/output"

if [ ! -f filtro_pdm_stuck_tb.v ]; then
    echo "ERRO: testbench do ATPG nao encontrado."
    echo "Execute antes: tmax -shell atpg/scripts/atpg_stuck.tcl"
    exit 1
fi

vcs -full64 -sverilog \
    +delay_mode_zero +notimingcheck +nospecify \
    +tetramax \
    -v "$SAED32_V" \
    "$RAIZ/$NETLIST" \
    filtro_pdm_stuck_tb.v \
    -o simv_atpg \
    -l compile_atpg.log

./simv_atpg -l sim_atpg.log

echo
grep -iE "error|mismatch|completed" sim_atpg.log | tail -5
