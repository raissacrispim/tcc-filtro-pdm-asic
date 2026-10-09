# ============================================================
# atpg_transition.tcl
# Geracao automatica de vetores de teste (ATPG)
# Modelo de falhas: transition (atraso, slow-to-rise/fall)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys TestMAX ATPG
#
# Uso (a partir da raiz do repositorio, apos atpg_stuck.tcl):
#
#   atpg/scripts/run_atpg.sh transition
#
# Lancamento pela captura (launch-on-capture): dois pulsos de
# clock funcional apos o shift, no mesmo clock do sistema.
#
# ATENCAO:
# Versao candidata, ainda nao validada no TestMAX ATPG.
# ============================================================

set SAED32_V /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v
set NETLIST  synth/netlist/filtro_pdm_syn.v
set SPF      synth/netlist/filtro_pdm_syn.spf

file mkdir atpg/reports
file mkdir atpg/output

set_messages -log atpg/reports/atpg_transition.log -replace

# ------------------------------------------------------------
# 1. Leitura da biblioteca e da netlist
# ------------------------------------------------------------

read_netlist $SAED32_V -library
read_netlist $NETLIST

run_build_model filtro_pdm


# ------------------------------------------------------------
# 2. Verificacao das regras de teste (DRC)
# ------------------------------------------------------------

set_delay -launch_cycle system_clock

run_drc $SPF


# ------------------------------------------------------------
# 3. ATPG para falhas de transicao
# ------------------------------------------------------------

set_faults -model transition
add_faults -all

run_atpg -auto_compression

report_summaries > atpg/reports/transition_summary.rpt


# ------------------------------------------------------------
# 4. Exportacao dos vetores
# ------------------------------------------------------------

write_patterns atpg/output/filtro_pdm_transition.stil \
    -format stil -replace

puts "ATPG transition: script executado ate o final."
puts "Cobertura em atpg/reports/transition_summary.rpt"

exit
