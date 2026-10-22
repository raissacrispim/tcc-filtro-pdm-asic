#!/bin/bash
# ============================================================
# Simulacao dos padroes de teste do ATPG (VCS)
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio, apos run_atpg.sh):
#
#   sim/scripts/sim_atpg.sh                         # synth stuck zero
#   sim/scripts/sim_atpg.sh pnr stuck zero          # pos-layout
#   sim/scripts/sim_atpg.sh pnr transition zero
#   sim/scripts/sim_atpg.sh pnr stuck sdf           # com atrasos (SDF)
#   sim/scripts/sim_atpg.sh pnr transition sdf
#
# Aplica a netlist com scan os padroes gerados pelo TestMAX
# (testbench do write_testbench) e compara as respostas com as
# esperadas. Todos os padroes sao carregados em serie pela porta
# scan_in (+tmax_serial), exercitando a cadeia de scan completa
# (1.332 celulas), e nao por carga paralela forcada.
#
#   zero  sem atrasos: valida a logica, a cadeia e o protocolo
#   sdf   atrasos pos-layout do PrimeTime (pnr/output/*_pt.sdf)
#         e verificacoes de setup/hold ativas. O periodo dos
#         padroes (STIL) e de 100 ns: a simulacao comprova os
#         padroes com os atrasos reais nessa frequencia, nao e
#         um teste em velocidade de um circuito rapido.
#
# Criterio de aprovacao: "completed with 0 mismatches" e
# nenhuma violacao de timing. Log em atpg/reports[/pnr]/.
# ============================================================

set -e
set -o pipefail

ETAPA=${1:-synth}
MODELO=${2:-stuck}
ATRASO=${3:-zero}

SAED32_V=/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v
RAIZ="$(cd "$(dirname "$0")/../.." && pwd)"

case "$ETAPA" in
    synth)
        NETLIST=$RAIZ/synth/netlist/filtro_pdm_syn.v
        SDF=$RAIZ/synth/netlist/filtro_pdm_syn.sdf
        DIR=$RAIZ/atpg/output
        REP=$RAIZ/atpg/reports
        ;;
    pnr)
        NETLIST=$RAIZ/pnr/output/filtro_pdm_pnr.v
        SDF=$RAIZ/pnr/output/filtro_pdm_pnr_pt.sdf
        DIR=$RAIZ/atpg/output/pnr
        REP=$RAIZ/atpg/reports/pnr
        ;;
    *)
        echo "ERRO: etapa deve ser 'synth' ou 'pnr'."; exit 1 ;;
esac

case "$MODELO" in
    stuck|transition) ;;
    *) echo "ERRO: modelo deve ser 'stuck' ou 'transition'."; exit 1 ;;
esac

TB=$DIR/filtro_pdm_${MODELO}_tb.v
if [ ! -f "$TB" ]; then
    echo "ERRO: testbench nao encontrado: $TB"
    echo "Execute antes: atpg/scripts/run_atpg.sh $MODELO $ETAPA"
    exit 1
fi

if [ "$ATRASO" = "sdf" ]; then
    if [ ! -f "$SDF" ]; then
        echo "ERRO: SDF nao encontrado: $SDF"; exit 1
    fi
    OPC="-sdf max:filtro_pdm_test.dut:$SDF +neg_tchk +sdfverbose"
elif [ "$ATRASO" = "zero" ]; then
    OPC="+delay_mode_zero +notimingcheck +nospecify"
else
    echo "ERRO: atraso deve ser 'zero' ou 'sdf'."; exit 1
fi

mkdir -p "$REP"
NOME=sim_${MODELO}_${ATRASO}
LOG=$REP/$NOME.log

# O testbench le o arquivo .dat pelo caminho relativo: executa
# na pasta dos padroes
cd "$DIR"
rm -rf "simv_$NOME" "simv_$NOME.daidir"

vcs -full64 -sverilog \
    -timescale=1ns/1ps \
    +tetramax \
    $OPC \
    -v "$SAED32_V" \
    "$NETLIST" \
    "$TB" \
    -o "simv_$NOME" \
    -l "$REP/${NOME}_compile.log" > /dev/null

# Carga em serie de todos os padroes
"./simv_$NOME" +tmax_serial=1000000 -l "$LOG" > /dev/null

echo "Etapa: $ETAPA  Modelo: $MODELO  Atrasos: $ATRASO"
grep -E "XTB: (Total number of patterns|Simulation of)" "$LOG" | tail -2
VIOL=$(grep -c "Timing violation" "$LOG" || true)
echo "Violacoes de timing: $VIOL"

if grep -q "completed with 0 mismatches" "$LOG" && [ "$VIOL" -eq 0 ]; then
    echo "SIMULACAO DOS PADROES APROVADA ($LOG)"
else
    echo "SIMULACAO DOS PADROES REPROVADA ($LOG)"
    grep -E "XTB Error|Error|mismatch" "$LOG" | head -10
    exit 1
fi
