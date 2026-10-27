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
# clock funcional apos o shift, no mesmo clock do sistema, com
# scan_en = 0 e entradas primarias fixas entre os dois pulsos.
# ============================================================

set SAED32_V /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/verilog/saed32nm.v
# SPF derivado do gerado pelo DC: identico, exceto "scan_en" = 0
# no test_setup, coerente com add_pi_constraints 0 scan_en
# (aviso V14). Gerado por run_atpg.sh com
# atpg/scripts/gera_spf_transition.py.
set SPF      atpg/spf/filtro_pdm_transition.spf
if {![file exists $SPF]} {
    puts "ERRO: $SPF nao encontrado. Execute por atpg/scripts/run_atpg.sh transition"
    exit 1
}

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

# Avisos do modelo por regra, com as instancias (P4 de
# docs/auditoria_final.md): N20 vem de duas UDPs do saed32nm.v
# do PDK; B7/B8 de portas de DFT de u_fir sem uso apos a
# reordenacao da cadeia; B9 de SYNOPSYS_UNCONNECTED_*; B10 de
# redes internas dos modelos Verilog das celulas.
report_violations -all > $REP/build_violations.rpt


# ------------------------------------------------------------
# 2. Verificacao das regras de teste (DRC)
# ------------------------------------------------------------

set_delay -launch_cycle system_clock

# Protocolo de teste em velocidade (P3 de docs/auditoria_final.md)
#
# Sem restricao, o TestMAX podia variar scan_en nos ciclos de
# lancamento e captura (aviso M487): no testador o scan_en e um
# sinal global lento, que fica em 0 entre o fim do shift e a
# captura. As demais entradas primarias (rst, pdm_in) tambem nao
# podem mudar entre o pulso de lancamento e o de captura, e as
# saidas nao sao medidas na captura em velocidade.
add_pi_constraints 0 scan_en
set_delay -nopo_measures

# -nopi_changes: entradas primarias fixas entre o lancamento e a
# captura. Com scan_en restrito, o TestMAX emite M977 ("scan
# enable can not be identified"): ele nao reconhece o scan_en
# como scan enable porque o valor ja esta fixado em 0, e a opcao
# vale para todas as entradas. Mantida de proposito: sem ela a
# cobertura cai de 97,27% para 97,25% (auditoria de 27/10) e as
# entradas poderiam mudar em velocidade, o que o testador nao
# garante. Os padroes simulam sem divergencias.
set_delay -nopi_changes

run_drc $SPF

report_violations -all > $REP/drc_violations_transition.rpt


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

# Testbench Verilog para a simulacao dos padroes
# (sim/scripts/sim_atpg.sh <etapa> transition)
write_testbench \
    -input $OUT/filtro_pdm_transition.stil \
    -output $OUT/filtro_pdm_transition_tb \
    -replace

puts "ATPG transition: script executado ate o final."
puts "Cobertura em $REP/transition_summary.rpt"

exit
