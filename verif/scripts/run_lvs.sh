#!/bin/bash

# ============================================================
# LVS (Layout Versus Schematic) com o IC Validator
# Filtro PDM CIC + FIR - SAED32 1P9M
#
# Uso (a partir da raiz do repositorio):
#
#   verif/scripts/run_lvs.sh
#
# Compara o layout (GDS) com a netlist pos-layout com
# conexoes VDD/VSS (filtro_pdm_lvs.v). A netlist Verilog e
# convertida pelo icv_nettran, usando o CDL das standard
# cells para descrever o conteudo de cada celula.
#
# Entradas: pnr/output/filtro_pdm_final.gds
#           pnr/output/filtro_pdm_lvs.v
# Saida:    verif/reports/lvs/  (resumo da comparacao)
#           verif/run_lvs/      (arquivos de execucao, ignorados
#                                pelo git)
# ============================================================

set -e
# Sem pipefail, o codigo de saida de 'icv ... | tee' seria o do tee
set -o pipefail

PDK=/Tools/PDK/SAED32/EDK_Digital
RUNSET=$PDK/tech/icv_lvs/saed32nm_1p9m_lvs_rules.rs
CDL=$PDK/lib/stdcell_rvt/lvs/saed32nm_rvt.cdl
TOPO=filtro_pdm

RAIZ="$(cd "$(dirname "$0")/../.." && pwd)"
# GDS final (textos de porta nas camadas de pino), gerado por
# finish.tcl via pnr/scripts/fix_gds_pin_text.py
GDS=$RAIZ/pnr/output/${TOPO}_final.gds
NETLIST=$RAIZ/pnr/output/${TOPO}_lvs.v

for arq in "$GDS" "$NETLIST"; do
    if [ ! -f "$arq" ]; then
        echo "ERRO: arquivo nao encontrado: $arq"
        echo "Execute antes: fc_shell -f pnr/scripts/finish.tcl"
        exit 1
    fi
done

rm -rf "$RAIZ/verif/run_lvs"
mkdir -p "$RAIZ/verif/run_lvs" "$RAIZ/verif/reports/lvs"
cd "$RAIZ/verif/run_lvs"

# O runset do PDK referencia o caminho da maquina onde o PDK foi
# gerado (/remote/exchange/.../icv/lvs/Include/functions.rs).
# Uma copia local aponta para o Include/ instalado no servidor.
sed "s#/remote/exchange/synopsys/SAED32_PDK/icv/lvs#$PDK/tech/icv_lvs#g" \
    "$RUNSET" > saed32nm_1p9m_lvs_rules_local.rs

if grep -q "/remote/exchange" saed32nm_1p9m_lvs_rules_local.rs; then
    echo "Aviso: ainda ha caminhos /remote/exchange no runset:"
    grep -n "/remote/exchange" saed32nm_1p9m_lvs_rules_local.rs
fi

# 1. CDL com o multiplicador m=N expandido em N transistores,
#    para que o esquematico seja agrupado como o layout
python3 "$RAIZ/verif/scripts/expand_cdl_m.py" "$CDL" saed32nm_rvt_expandido.cdl

# 2. Netlist Verilog + CDL das celulas -> netlist do ICV
icv_nettran \
    -verilog "$NETLIST" \
    -sp saed32nm_rvt_expandido.cdl \
    -outName $TOPO.icv.net \
    -wireLog icv_nettran_wires.log \
    2>&1 | tee icv_nettran.log

# 3. Comparacao layout x netlist
icv -i "$GDS" -c $TOPO -f GDSII \
    -s $TOPO.icv.net -sf ICV -stc $TOPO \
    -I "$PDK/tech/icv_lvs" \
    saed32nm_1p9m_lvs_rules_local.rs \
    2>&1 | tee icv_lvs.log

for arq in $TOPO.LVS_ERRORS $TOPO.RESULTS icv_nettran.log icv_nettran_wires.log icv_lvs.log; do
    [ -f "$arq" ] && cp "$arq" "$RAIZ/verif/reports/lvs/"
done

echo
echo "============================================"
echo "RESUMO DO LVS"
echo "============================================"
grep -iE "pass|fail|match|error" "$TOPO.LVS_ERRORS" 2>/dev/null | head -20 \
    || echo "Arquivo $TOPO.LVS_ERRORS nao encontrado: verifique icv_lvs.log"
echo
echo "Relatorios em verif/reports/lvs/"

# Criterio de aprovacao: comparacao eletrica PASS e nenhuma
# violacao de regra no .RESULTS (inclui text_net:text_short,
# curto entre etiquetas de portas). A versao anterior olhava so
# a comparacao, e um text_short passou despercebido
# (docs/auditoria_final.md, P1).
if [ ! -f "$TOPO.RESULTS" ]; then
    echo "LVS REPROVADO: $TOPO.RESULTS nao gerado"
    exit 1
fi
VIOL=$(awk '/Violations Found/{f=1; next} f && /^- - -/{exit} f && /v = [1-9][0-9]*/{print}' "$TOPO.RESULTS")
if [ -n "$VIOL" ]; then
    echo "Violacoes de regra no LVS:"
    echo "$VIOL"
fi
if grep -q "LVS Compare Result: PASS" "$TOPO.RESULTS" && [ -z "$VIOL" ]; then
    echo "LVS APROVADO: comparacao PASS e 0 violacoes de regra"
else
    echo "LVS REPROVADO"
    exit 1
fi
