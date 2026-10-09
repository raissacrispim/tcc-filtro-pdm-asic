# ============================================================
# atpg_stuck.tcl
# Geracao automatica de vetores de teste (ATPG)
# Modelo de falhas: stuck-at (colagem em 0 / colagem em 1)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys TestMAX ATPG
#
# Uso (a partir da raiz do repositorio):
#
#   tmax -shell atpg/scripts/atpg_stuck.tcl
#
# Entradas:
#   synth/netlist/filtro_pdm_syn.v    netlist com scan
#   synth/netlist/filtro_pdm_syn.spf  protocolo de teste
#
# Para usar a netlist pos-layout, troque NETLIST abaixo por
# pnr/output/filtro_pdm_pnr.v.
#
# ATENCAO:
# Versao candidata, ainda nao validada no TestMAX ATPG.
# ============================================================

set SAED32_V /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v
set NETLIST  synth/netlist/filtro_pdm_syn.v
set SPF      synth/netlist/filtro_pdm_syn.spf

file mkdir atpg/reports
file mkdir atpg/output

set_messages -log atpg/reports/atpg_stuck.log -replace

# ------------------------------------------------------------
# 1. Leitura da biblioteca e da netlist
# ------------------------------------------------------------

read_netlist $SAED32_V -library
read_netlist $NETLIST

run_build_model filtro_pdm


# ------------------------------------------------------------
# 2. Verificacao das regras de teste (DRC)
# ------------------------------------------------------------

run_drc $SPF

report_rules -fail > atpg/reports/drc_rules.rpt
report_scan_chains > atpg/reports/scan_chains.rpt


# ------------------------------------------------------------
# 3. ATPG para falhas stuck-at
# ------------------------------------------------------------

set_faults -model stuck
add_faults -all

run_atpg -auto_compression

report_summaries > atpg/reports/stuck_summary.rpt
report_faults -summary > atpg/reports/stuck_faults.rpt


# ------------------------------------------------------------
# 4. Exportacao dos vetores e do testbench de simulacao
# ------------------------------------------------------------

write_patterns atpg/output/filtro_pdm_stuck.stil \
    -format stil -replace

write_testbench \
    -input atpg/output/filtro_pdm_stuck.stil \
    -output atpg/output/filtro_pdm_stuck_tb \
    -replace

puts "ATPG stuck-at: script executado ate o final."
puts "Cobertura em atpg/reports/stuck_summary.rpt"

exit
