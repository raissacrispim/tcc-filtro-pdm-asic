# ============================================================
# atpg_stuck.tcl
# Geracao automatica de vetores de teste (ATPG)
# Modelo de falhas: stuck-at (colagem em 0 / colagem em 1)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys TestMAX ATPG
#
# Uso (a partir da raiz do repositorio):
#
#   atpg/scripts/run_atpg.sh
#
# Entradas:
#   synth/netlist/filtro_pdm_syn.v    netlist com scan
#   synth/netlist/filtro_pdm_syn.spf  protocolo de teste
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

set_messages -log $REP/atpg_stuck.log -replace

# ------------------------------------------------------------
# 1. Leitura da biblioteca e da netlist
# ------------------------------------------------------------

read_netlist $SAED32_V -library
read_netlist $NETLIST

run_build_model filtro_pdm

# Avisos do modelo por regra, com as instancias (P4 de
# docs/auditoria_final.md): N20 vem de duas UDPs do saed32nm.v
# do PDK; B7/B8 de portas de DFT de u_fir sem uso apos a
# reordenacao da cadeia; B9 de SYNOPSYS_UNCONNECTED_*; B10 de
# redes internas dos modelos Verilog das celulas.
report_violations -all > $REP/build_violations.rpt


# ------------------------------------------------------------
# 2. Verificacao das regras de teste (DRC)
# ------------------------------------------------------------

# scan_en nao e restringido na captura: no teste stuck-at (lento)
# o testador pode mudar scan_en entre ciclos, e o ATPG usa esse
# grau de liberdade. No transition ele e fixado em 0 (M487).
run_drc $SPF

report_violations -all > $REP/drc_violations_stuck.rpt
report_rules -fail > $REP/drc_rules.rpt
report_scan_chains > $REP/scan_chains.rpt


# ------------------------------------------------------------
# 3. ATPG para falhas stuck-at
# ------------------------------------------------------------

set_faults -model stuck
add_faults -all

# Limite de tentativas por falha (padrao: 10).
# Com o padrao, ~1.400 falhas foram abandonadas (abort) e
# ficaram como "not detected". Um limite maior permite ao
# ATPG insistir nessas falhas.
set_atpg -abort_limit 200

run_atpg -auto_compression

report_summaries > $REP/stuck_summary.rpt
report_faults -summary > $REP/stuck_faults.rpt


# ------------------------------------------------------------
# 4. Exportacao dos vetores e do testbench de simulacao
# ------------------------------------------------------------

write_patterns $OUT/filtro_pdm_stuck.stil \
    -format stil -replace

write_testbench \
    -input $OUT/filtro_pdm_stuck.stil \
    -output $OUT/filtro_pdm_stuck_tb \
    -replace

puts "ATPG stuck-at: script executado ate o final."
puts "Cobertura em $REP/stuck_summary.rpt"

exit
