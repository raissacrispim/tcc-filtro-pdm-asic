#!/bin/bash

# ============================================================
# Compilacao da simulacao gate-level (VCS)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio):
#
#   sim/scripts/compile_gls.sh                 # netlist da sintese
#   sim/scripts/compile_gls.sh pnr             # netlist pos-layout
#   sim/scripts/compile_gls.sh pnr sdf         # pos-layout com SDF
#
# Gera sim/simv_filtro_gls, usado por run_gls_regression.sh.
#
# A netlist possui as portas de scan (DFT). O testbench e
# compilado com +define+DFT e mantem scan_en = 0.
# ============================================================

set -e

SAED32_V=/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v

ETAPA=${1:-synth}
ATRASO=${2:-zero}

cd "$(dirname "$0")/.."

case "$ETAPA" in
    synth)
        NETLIST=../synth/netlist/filtro_pdm_syn.v
        SDF=../synth/netlist/filtro_pdm_syn.sdf
        ;;
    pnr)
        NETLIST=../pnr/output/filtro_pdm_pnr.v
        SDF=../pnr/output/filtro_pdm_pnr.sdf
        ;;
    *)
        echo "ERRO: etapa deve ser 'synth' ou 'pnr'."
        exit 1
        ;;
esac

if [ ! -f "$NETLIST" ]; then
    echo "ERRO: netlist nao encontrada: $NETLIST"
    exit 1
fi

if [ "$ATRASO" = "sdf" ]; then
    # Simulacao com atrasos reais (back-annotation)
    OPCOES_ATRASO="-sdf max:tb_filtro_pdm_golden.dut:$SDF +neg_tchk"
else
    # Simulacao funcional, sem atrasos das celulas
    OPCOES_ATRASO="+delay_mode_zero +notimingcheck +nospecify"
fi

echo "Netlist: $NETLIST"
echo "Atrasos: $ATRASO"

# Remove executavel antigo para nao simular uma netlist anterior
# caso a compilacao falhe
rm -rf simv_filtro_gls simv_filtro_gls.daidir

# A netlist do Design Compiler nao possui `timescale;
# -timescale define a unidade padrao para os modulos sem ela.
vcs -full64 -sverilog -kdb -debug_access+all \
    -timescale=1ns/1ps \
    +define+DFT \
    $OPCOES_ATRASO \
    -v "$SAED32_V" \
    "$NETLIST" \
    ../tb/tb_filtro_pdm_golden.sv \
    -o simv_filtro_gls \
    -l compile_gls.log

echo "Compilado: sim/simv_filtro_gls"
