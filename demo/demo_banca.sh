#!/bin/bash
# ============================================================
# demo_banca.sh
# Demonstracao do filtro PDM (CIC + FIR) em um comando
#
# Uso (no servidor, com o ambiente Synopsys carregado):
#
#   source /Tools/synopsys-scripts/snps.sh
#   bash ~/tcc_filtro/demo/demo_banca.sh            # RTL + pos-layout
#   bash ~/tcc_filtro/demo/demo_banca.sh --rapido   # so RTL
#
# Etapas:
#   1. confere os hashes do congelamento v1.0-tcc no projeto
#   2. clona a tag v1.0-tcc numa pasta nova (~/tcc_demo_<data>)
#   3. regenera os vetores com o Golden Model e confere que sao
#      identicos aos da tag
#   4. simula o RTL nos 10 testes contra o Golden Model
#   5. simula a netlist pos-layout com SDF nos 10 testes
#
# O projeto em ~/tcc_filtro so e lido. Tudo o que e gerado fica
# na pasta da demonstracao (outro local: TCC_DEMO=<dir>).
# ============================================================

set -o pipefail

PROJ=${TCC_PROJ:-$HOME/tcc_filtro}
TAG=v1.0-tcc
DEST=${TCC_DEMO:-$HOME/tcc_demo_$(date +%Y%m%d_%H%M%S)}
RAPIDO=0
[ "$1" = "--rapido" ] && RAPIDO=1

TESTES=(
    test_01_10k test_02_30k test_03_50k test_04_80k
    test_05_50k_ruido test_06_burst_50k_ruido test_07_fundo_escala
    test_08_50k_interf_130k test_09_varredura test_10_impulso
)

INICIO=$(date +%s)
FALHAS=0
etapa() { echo; echo "=== $1 ==="; }
falhou() { echo "FALHOU: $1"; FALHAS=$((FALHAS + 1)); }

if ! command -v vcs > /dev/null; then
    echo "ERRO: vcs nao encontrado."
    echo "Execute antes: source /Tools/synopsys-scripts/snps.sh"
    exit 1
fi
if [ -e "$DEST" ]; then
    echo "ERRO: $DEST ja existe e nao sera alterado."
    exit 1
fi

# ------------------------------------------------------------
etapa "1/5 Congelamento v1.0-tcc (hashes SHA-256)"
# ------------------------------------------------------------
CONGELAMENTO="arquivos diferentes (ver acima)"
if ( cd "$PROJ" && sha256sum -c --quiet docs/congelamento_v1.0.sha256 ); then
    CONGELAMENTO="conferido"
    echo "OK: $(grep -c . "$PROJ/docs/congelamento_v1.0.sha256") arquivos conferem"
    echo "    (GDSII, SPEF, netlists, SDF, SDC, SPF, padroes ATPG, coeficientes e RTL)"
else
    falhou "algum arquivo difere do congelamento"
fi

# ------------------------------------------------------------
etapa "2/5 Copia da versao congelada"
# ------------------------------------------------------------
git clone -q "$PROJ" "$DEST" && \
    git -C "$DEST" -c advice.detachedHead=false checkout -q "$TAG" || {
    echo "ERRO: nao foi possivel clonar a tag $TAG"; exit 1; }
echo "Pasta: $DEST"
echo "Versao: $(git -C "$DEST" describe --tags) ($(git -C "$DEST" rev-parse --short HEAD))"

# ------------------------------------------------------------
etapa "3/5 Golden Model (Python)"
# ------------------------------------------------------------
python3 -c "
import sys
sys.path.insert(0, '$PROJ/golden_model')
import golden_model as g
g.exportar_vetores('$DEST/vectors')
" || falhou "Golden Model"
if [ -z "$(git -C "$DEST" status --porcelain vectors)" ]; then
    echo "OK: vetores regenerados identicos aos da versao congelada"
else
    falhou "vetores diferentes dos da versao congelada"
    git -C "$DEST" status --short vectors | head
fi

# ------------------------------------------------------------
etapa "4/5 Simulacao RTL x Golden Model (10 testes)"
# ------------------------------------------------------------
cd "$DEST/sim" || exit 1
vcs -full64 -sverilog -kdb -debug_access+all \
    ../rtl/integrador.sv ../rtl/cic_integradores.sv ../rtl/decimador.sv \
    ../rtl/comb.sv ../rtl/cic_combs.sv ../rtl/cic.sv ../rtl/fir.sv \
    ../rtl/filtro_pdm.sv ../tb/tb_filtro_pdm_golden.sv \
    -o simv_filtro_rtl -l compile_rtl.log > /dev/null \
    || { falhou "compilacao RTL (sim/compile_rtl.log)"; }

PASS_RTL=0
for t in "${TESTES[@]}"; do
    ./simv_filtro_rtl +TEST="$t" > "rtl_$t.log" 2>&1
    if grep -q "Erros encontrados  : 0" "rtl_$t.log" &&
       grep -q "FILTRO COMPLETO APROVADO" "rtl_$t.log"; then
        echo "[PASS] $t"; PASS_RTL=$((PASS_RTL + 1))
    else
        echo "[FAIL] $t (sim/rtl_$t.log)"; FALHAS=$((FALHAS + 1))
    fi
done
echo "RTL: $PASS_RTL/${#TESTES[@]} aprovados (600 amostras por teste, comparadas uma a uma)"

# ------------------------------------------------------------
etapa "5/5 Simulacao pos-layout com SDF (10 testes)"
# ------------------------------------------------------------
PASS_PNR="-"
if [ "$RAPIDO" -eq 1 ]; then
    echo "Pulada (--rapido)"
else
    cd "$DEST" || exit 1
    sim/scripts/compile_gls.sh pnr sdf > sim/compile_gls_terminal.log 2>&1 \
        || falhou "compilacao pos-layout (sim/compile_gls_terminal.log)"
    grep -E "Total (errors|warnings)" sim/compile_gls.log | sed 's/^ */SDF: /'
    sim/scripts/run_gls_regression.sh | grep -E "^\[(PASS|FAIL)\]" | tee sim/regressao_pnr.txt
    PASS_PNR=$(grep -c "^\[PASS\]" sim/regressao_pnr.txt)
    [ "$PASS_PNR" -eq "${#TESTES[@]}" ] || FALHAS=$((FALHAS + 1))
    PASS_PNR="$PASS_PNR/${#TESTES[@]}"
fi

# ------------------------------------------------------------
FIM=$(date +%s)
echo
echo "============================================"
echo "RESUMO DA DEMONSTRACAO ($TAG)"
echo "============================================"
echo "Congelamento        : $CONGELAMENTO"
echo "RTL x Golden Model  : $PASS_RTL/${#TESTES[@]}"
echo "Pos-layout com SDF  : $PASS_PNR"
echo "Tempo total         : $(( (FIM - INICIO) / 60 )) min $(( (FIM - INICIO) % 60 )) s"
if [ "$FALHAS" -eq 0 ]; then
    echo "RESULTADO           : APROVADO"
else
    echo "RESULTADO           : $FALHAS falha(s), ver mensagens acima"
fi
echo "============================================"
echo
echo "Resposta em frequencia no Verdi (varredura de 0 a 150 kHz):"
echo "  cd $DEST/sim"
echo "  ./simv_filtro_rtl +TEST=test_09_varredura > /dev/null"
echo "  verdi -dbdir simv_filtro_rtl.daidir -ssf filtro_pdm.fsdb &"
echo "  (tb_filtro_pdm_golden -> dut -> y_out; Analog -> Convert to Analog)"
echo
echo "Imagens do layout e das simulacoes: $PROJ/docs/imagens.md"
