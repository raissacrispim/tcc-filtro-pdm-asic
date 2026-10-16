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
#   sim/scripts/compile_gls.sh pnr sdf saif    # idem, gravando SAIF
#   sim/scripts/compile_gls.sh pnr sdf_fc      # SDF do Fusion Compiler
#
# SDF pos-layout: gerado pelo PrimeTime (sta/scripts/run_sdf_gls.sh).
# O SDF do write_sdf do FC (sdf_fc) e mantido so para comparacao:
# ele escapa os bits das portas de barramento (y_out\[18\]),
# o que gera 19 erros SDFCOM_PONF no VCS (docs/auditoria_sdf.md).
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
ATIVIDADE=${3:-}

cd "$(dirname "$0")/.."

case "$ETAPA" in
    synth)
        NETLIST=../synth/netlist/filtro_pdm_syn.v
        SDF=../synth/netlist/filtro_pdm_syn.sdf
        ;;
    pnr)
        NETLIST=../pnr/output/filtro_pdm_pnr.v
        if [ "$ATRASO" = "sdf_fc" ]; then
            SDF=../pnr/output/filtro_pdm_pnr.sdf
        else
            SDF=../pnr/output/filtro_pdm_pnr_pt.sdf
        fi
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

if [ "$ATRASO" = "sdf" ] || [ "$ATRASO" = "sdf_fc" ]; then
    if [ ! -f "$SDF" ]; then
        echo "ERRO: SDF nao encontrado: $SDF"
        [ "$ETAPA" = "pnr" ] && echo "Execute antes: sta/scripts/run_sdf_gls.sh"
        exit 1
    fi
    # Simulacao com atrasos reais (back-annotation).
    # +neg_tchk: mantem os valores negativos de hold da biblioteca.
    # +sdfverbose: lista todas as mensagens de anotacao.
    OPCOES_ATRASO="-sdf max:tb_filtro_pdm_golden.dut:$SDF +neg_tchk +sdfverbose"
else
    # Simulacao funcional, sem atrasos das celulas
    OPCOES_ATRASO="+delay_mode_zero +notimingcheck +nospecify"
fi

# Gravacao da atividade de chaveamento (SAIF) para potencia
if [ "$ATIVIDADE" = "saif" ]; then
    OPCOES_SAIF="+define+SAIF"
else
    OPCOES_SAIF=""
fi

echo "Netlist: $NETLIST"
echo "Atrasos: $ATRASO"
[ -n "${SDF:-}" ] && [ "$ATRASO" != "zero" ] && echo "SDF:     $SDF"

# Remove executavel antigo para nao simular uma netlist anterior
# caso a compilacao falhe
rm -rf simv_filtro_gls simv_filtro_gls.daidir

# A netlist do Design Compiler nao possui `timescale;
# -timescale define a unidade padrao para os modulos sem ela.
vcs -full64 -sverilog -kdb -debug_access+all \
    -timescale=1ns/1ps \
    +define+DFT \
    $OPCOES_SAIF \
    $OPCOES_ATRASO \
    -v "$SAED32_V" \
    "$NETLIST" \
    ../tb/tb_filtro_pdm_golden.sv \
    -o simv_filtro_gls \
    -l compile_gls.log

if [ "$ATRASO" != "zero" ]; then
    echo "Anotacao do SDF (mensagens do VCS):"
    grep -oE 'SDFCOM_[A-Z]+' compile_gls.log | sort | uniq -c || true
    grep -E 'Total (errors|warnings)' compile_gls.log || \
        echo "  nenhum erro ou aviso de anotacao"
fi

echo "Compilado: sim/simv_filtro_gls"
