#!/bin/bash
# ============================================================
# sim_ondas_amostradas.sh
# Formas de onda pos-layout com a saida amostrada no clock
# Projeto: Filtro PDM CIC + FIR (versao v1.0-tcc)
#
# Uso (depois de sim_ondas.sh):
#
#   bash ~/tcc_filtro/imagens/scripts/sim_ondas_amostradas.sh
#
# Trabalha na copia criada por sim_ondas.sh (~/tcc_imagens_sim,
# ou TCC_ONDAS=<dir>). Compila a netlist pos-layout com SDF,
# com as mesmas opcoes de sim/scripts/compile_gls.sh, mais o
# modulo imagens/sim/amostra_saida.sv (sinal y_amostrado), num
# executavel proprio: sim/simv_filtro_gls_amostra.
#
# Gera onda_pnr_amostra_<teste>/filtro_pdm.fsdb. As pastas e os
# executaveis existentes nao sao alterados.
# ============================================================

set -o pipefail

PROJ=${TCC_PROJ:-$HOME/tcc_filtro}
DEST=${TCC_ONDAS:-$HOME/tcc_imagens_sim}
SAED32_V=/Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v
AMOSTRA=$PROJ/imagens/sim/amostra_saida.sv

TESTES=(
    test_08_50k_interf_130k
    test_09_varredura
)

if ! command -v vcs > /dev/null; then
    echo "ERRO: vcs nao encontrado."
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"
    exit 1
fi
if [ ! -d "$DEST/sim" ]; then
    echo "ERRO: $DEST nao encontrado. Execute antes sim_ondas.sh"
    exit 1
fi
for t in "${TESTES[@]}"; do
    if [ -e "$DEST/onda_pnr_amostra_$t" ]; then
        echo "ERRO: $DEST/onda_pnr_amostra_$t ja existe e nao sera alterado."
        exit 1
    fi
done
if [ -e "$DEST/sim/simv_filtro_gls_amostra" ]; then
    echo "ERRO: $DEST/sim/simv_filtro_gls_amostra ja existe e nao sera alterado."
    exit 1
fi

cd "$DEST" || exit 1
echo "Copia: $DEST ($(git describe --tags) $(git rev-parse --short HEAD))"

echo "Compilando pos-layout com SDF e amostragem da saida..."
( cd sim && vcs -full64 -sverilog -kdb -debug_access+all \
    -timescale=1ns/1ps \
    +define+DFT \
    -sdf max:tb_filtro_pdm_golden.dut:../pnr/output/filtro_pdm_pnr_pt.sdf \
    +neg_tchk +sdfverbose \
    -v "$SAED32_V" \
    ../pnr/output/filtro_pdm_pnr.v \
    ../tb/tb_filtro_pdm_golden.sv \
    "$AMOSTRA" \
    -o simv_filtro_gls_amostra \
    -l compile_gls_amostra.log > /dev/null ) \
    || { echo "ERRO: compilacao (sim/compile_gls_amostra.log)"; exit 1; }
grep -E 'Total (errors|warnings)' sim/compile_gls_amostra.log

FALHAS=0
for t in "${TESTES[@]}"; do
    dir=onda_pnr_amostra_$t
    mkdir "$dir"
    ( cd "$dir" && ../sim/simv_filtro_gls_amostra +TEST="$t" > sim.log 2>&1 )
    if grep -q "Erros encontrados  : 0" "$dir/sim.log" &&
       grep -q "FILTRO COMPLETO APROVADO" "$dir/sim.log" &&
       [ -s "$dir/filtro_pdm.fsdb" ]; then
        echo "[PASS] $dir  ($(du -h "$dir/filtro_pdm.fsdb" | cut -f1))"
    else
        echo "[FAIL] $dir  (ver $dir/sim.log)"
        FALHAS=$((FALHAS + 1))
    fi
done

echo "============================================"
if [ "$FALHAS" -eq 0 ]; then
    echo "ONDAS PRONTAS: $DEST/onda_pnr_amostra_*/filtro_pdm.fsdb"
    echo "Sinal amostrado: amostra_saida.y_amostrado"
else
    echo "FALHAS: $FALHAS (as ondas desses testes nao devem ser usadas)"
fi
echo "============================================"
