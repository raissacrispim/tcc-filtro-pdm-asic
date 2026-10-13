#!/bin/bash

# ============================================================
# Geracao da atividade de chaveamento (SAIF) pos-layout
# Filtro PDM CIC + FIR
#
# Uso (a partir da raiz do repositorio):
#
#   sim/scripts/run_saif.sh                    # test_05_50k_ruido
#   sim/scripts/run_saif.sh test_02_30k        # outro teste
#
# Compila a netlist pos-layout com atrasos (SDF) e gravacao
# de SAIF, executa um teste e copia o SAIF para
# pnr/activity/, onde e lido por pnr/scripts/power_saif.tcl.
#
# Teste padrao: senoide de 50 kHz com ruido, representativo
# do sinal de ultrassom em operacao normal.
# ============================================================

set -e

TESTE=${1:-test_05_50k_ruido}

RAIZ="$(cd "$(dirname "$0")/../.." && pwd)"

"$RAIZ/sim/scripts/compile_gls.sh" pnr sdf saif

cd "$RAIZ/sim"

rm -f filtro_pdm.saif

./simv_filtro_gls +TEST="$TESTE" > "saif_${TESTE}.log" 2>&1

grep -E "Erros encontrados|APROVADO|REPROVADO|SAIF gravado|toggle" \
    "saif_${TESTE}.log"

if [ ! -s filtro_pdm.saif ]; then
    echo "ERRO: filtro_pdm.saif nao foi gerado."
    echo "Mensagens do VCS sobre o SAIF:"
    grep -iE "saif|toggle|error" "saif_${TESTE}.log" | head -20
    exit 1
fi

mkdir -p "$RAIZ/pnr/activity"
cp filtro_pdm.saif "$RAIZ/pnr/activity/filtro_pdm.saif"

echo
echo "SAIF copiado para pnr/activity/filtro_pdm.saif"
echo "Proximo passo: fc_shell -f pnr/scripts/power_saif.tcl"
