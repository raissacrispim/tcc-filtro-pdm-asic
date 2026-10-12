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
set SPF      synth/netlist/filtro_pdm_syn.spf

# Netlist da sintese (padrao) ou pos-layout (ATPG_ETAPA=pnr,
# definido por run_atpg.sh). No layout a cadeia de scan foi
# reordenada pelo placement; o ATPG pos-layout confirma a
# cadeia e a cobertura na netlist final.
if {[info exists env(ATPG_ETAPA)] && $env(ATPG_ETAPA) eq "pnr"} {
    set NETLIST pnr/output/filtro_pdm_pnr.v
    set REP     atpg/reports/pnr
    set OUT     atpg/output/pnr
} else {
    set NETLIST synth/netlist/filtro_pdm_syn.v
    set REP     atpg/reports
    set OUT     atpg/output
}

file mkdir $REP
file mkdir $OUT

set_messages -log $REP/atpg_transition.log -replace

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

# Limite de tentativas por falha (padrao: 10).
# Com o padrao, ~1.400 falhas foram abandonadas (abort) e
# ficaram como "not detected". Um limite maior permite ao
# ATPG insistir nessas falhas.
set_atpg -abort_limit 200

run_atpg -auto_compression

report_summaries > $REP/transition_summary.rpt


# ------------------------------------------------------------
# 4. Exportacao dos vetores
# ------------------------------------------------------------

write_patterns $OUT/filtro_pdm_transition.stil \
    -format stil -replace

puts "ATPG transition: script executado ate o final."
puts "Cobertura em $REP/transition_summary.rpt"

exit
