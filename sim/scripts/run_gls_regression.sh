#!/bin/bash

# ============================================================
# Regressao funcional pos-sintese
# Filtro PDM CIC + FIR
# ============================================================

set -e

TESTS=(
    test_01_10k
    test_02_30k
    test_03_50k
    test_04_80k
    test_05_50k_ruido
    test_06_burst_50k_ruido
    test_07_fundo_escala
)

cd "$(dirname "$0")/.."

if [ ! -x "./simv_filtro_gls" ]; then
    echo "ERRO: executavel simv_filtro_gls nao encontrado."
    echo "Compile a simulacao gate-level antes de executar a regressao."
    exit 1
fi

echo "============================================"
echo "REGRESSAO FUNCIONAL POS-SINTESE"
echo "============================================"

PASS=0
FAIL=0

for TEST in "${TESTS[@]}"; do

    echo
    echo "Executando: $TEST"
    echo "--------------------------------------------"

    LOG="gls_${TEST}.log"

    ./simv_filtro_gls +TEST="$TEST" > "$LOG" 2>&1

    if grep -q "Erros encontrados  : 0" "$LOG" &&
       grep -q "FILTRO COMPLETO APROVADO" "$LOG"; then

        echo "[PASS] $TEST"
        PASS=$((PASS + 1))

    else

        echo "[FAIL] $TEST"
        FAIL=$((FAIL + 1))

    fi

done

echo
echo "============================================"
echo "RESUMO DA REGRESSAO"
echo "============================================"
echo "Testes executados : ${#TESTS[@]}"
echo "Aprovados         : $PASS"
echo "Falharam          : $FAIL"
echo "============================================"

if [ "$FAIL" -eq 0 ]; then
    echo "REGRESSAO GLS APROVADA"
    exit 0
else
    echo "REGRESSAO GLS REPROVADA"
    exit 1
fi
