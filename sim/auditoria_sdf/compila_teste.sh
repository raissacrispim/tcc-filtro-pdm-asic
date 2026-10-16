#!/bin/bash
# Compilacao isolada da GLS para a auditoria do SDF.
# Uso: compila_teste.sh <diretorio> <arquivo.sdf | nenhum>
#
# Usa uma copia em $SDF_TESTE (padrao ~/sdf_teste) contendo
# netlist/filtro_pdm_pnr.v, tb/ e vectors/, para que o testbench
# (que grava ../vectors/*_output_rtl.txt) nao altere o repositorio.
AQUI="$(cd "$(dirname "$0")" && pwd)"
R=${SDF_TESTE:-$HOME/sdf_teste}
N=$1
if [ "$2" = nenhum ]; then OPC=""
else OPC="-sdf max:tb_filtro_pdm_golden.dut:$(readlink -f "$2") +neg_tchk +sdfverbose"; fi
mkdir -p "$R/$N" && cd "$R/$N" && rm -rf simv simv.daidir
vcs -full64 -sverilog -kdb -debug_access+all -timescale=1ns/1ps +define+DFT $OPC \
  -v /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v \
  "$R/netlist/filtro_pdm_pnr.v" "$R/tb/tb_filtro_pdm_golden.sv" "$AQUI/mede_clkq.sv" \
  -top tb_filtro_pdm_golden -top mede_clkq -o simv -l compile.log > /dev/null \
  || { echo "ERRO de compilacao: $R/$N/compile.log"; exit 1; }
echo "== $N =="
grep -oE 'SDFCOM_[A-Z]+' compile.log | sort | uniq -c
grep -iE 'Total (errors|warnings)' compile.log
