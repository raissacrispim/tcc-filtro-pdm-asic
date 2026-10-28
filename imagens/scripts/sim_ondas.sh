#!/bin/bash
# ============================================================
# sim_ondas.sh
# Formas de onda (FSDB) para as capturas no Verdi
# Projeto: Filtro PDM CIC + FIR (versao v1.0-tcc)
#
# Uso:
#
#   bash ~/tcc_filtro/imagens/scripts/sim_ondas.sh
#
# Trabalha numa copia nova do repositorio, na tag v1.0-tcc
# (padrao ~/tcc_imagens_sim; outro local: TCC_ONDAS=<dir>).
# O projeto em ~/tcc_filtro nao e alterado: as saidas
# *_output_rtl.txt e os executaveis ficam so na copia.
#
# Gera, na copia, uma pasta por simulacao com filtro_pdm.fsdb:
#   onda_rtl_<teste>/   RTL
#   onda_pnr_<teste>/   netlist pos-layout com SDF do PrimeTime
# e o resumo PASS/FAIL de cada teste.
# ============================================================

set -o pipefail

PROJ=${TCC_PROJ:-$HOME/tcc_filtro}
DEST=${TCC_ONDAS:-$HOME/tcc_imagens_sim}
TAG=v1.0-tcc

TESTES_RTL=(
    test_01_10k
    test_03_50k
    test_04_80k
    test_08_50k_interf_130k
    test_09_varredura
    test_10_impulso
)
TESTES_PNR=(
    test_08_50k_interf_130k
    test_09_varredura
)

if ! command -v vcs > /dev/null; then
    echo "ERRO: vcs nao encontrado."
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"
    exit 1
fi

if [ -e "$DEST" ]; then
    echo "ERRO: $DEST ja existe e nao sera alterado."
    echo "Use outro diretorio: TCC_ONDAS=~/tcc_imagens_sim2 bash $0"
    exit 1
fi

git clone -q "$PROJ" "$DEST" || { echo "ERRO: git clone"; exit 1; }
cd "$DEST" || exit 1
git -c advice.detachedHead=false checkout -q "$TAG" || { echo "ERRO: tag $TAG"; exit 1; }
echo "Copia: $DEST ($(git describe --tags) $(git rev-parse --short HEAD))"

# ------------------------------------------------------------
# Compilacao: RTL e pos-layout com SDF
# ------------------------------------------------------------

echo "Compilando RTL..."
( cd sim && vcs -full64 -sverilog -kdb -debug_access+all \
    ../rtl/integrador.sv ../rtl/cic_integradores.sv ../rtl/decimador.sv \
    ../rtl/comb.sv ../rtl/cic_combs.sv ../rtl/cic.sv ../rtl/fir.sv \
    ../rtl/filtro_pdm.sv ../tb/tb_filtro_pdm_golden.sv \
    -o simv_filtro_rtl -l compile_rtl.log > /dev/null ) \
    || { echo "ERRO: compilacao RTL (sim/compile_rtl.log)"; exit 1; }

echo "Compilando pos-layout com SDF..."
sim/scripts/compile_gls.sh pnr sdf > compile_gls_terminal.log 2>&1 \
    || { echo "ERRO: compilacao pos-layout (compile_gls_terminal.log)"; exit 1; }
grep -A3 "Anotacao do SDF" compile_gls_terminal.log

# ------------------------------------------------------------
# Simulacoes: uma pasta por teste (o testbench le ../vectors)
# ------------------------------------------------------------

FALHAS=0
roda() {
    local tipo=$1 simv=$2 teste=$3
    local dir=onda_${tipo}_${teste}
    mkdir "$dir"
    ( cd "$dir" && "../sim/$simv" +TEST="$teste" > sim.log 2>&1 )
    if grep -q "Erros encontrados  : 0" "$dir/sim.log" &&
       grep -q "FILTRO COMPLETO APROVADO" "$dir/sim.log" &&
       [ -s "$dir/filtro_pdm.fsdb" ]; then
        echo "[PASS] $dir  ($(du -h "$dir/filtro_pdm.fsdb" | cut -f1))"
    else
        echo "[FAIL] $dir  (ver $dir/sim.log)"
        FALHAS=$((FALHAS + 1))
    fi
}

for t in "${TESTES_RTL[@]}"; do roda rtl simv_filtro_rtl "$t"; done
for t in "${TESTES_PNR[@]}"; do roda pnr simv_filtro_gls "$t"; done

echo "============================================"
if [ "$FALHAS" -eq 0 ]; then
    echo "ONDAS PRONTAS: $DEST/onda_*/filtro_pdm.fsdb"
else
    echo "FALHAS: $FALHAS (as ondas desses testes nao devem ser usadas)"
fi
echo "Projeto original nao alterado: confira com 'git -C $PROJ status --short'"
echo "============================================"
