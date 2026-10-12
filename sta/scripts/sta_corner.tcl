# ============================================================
# sta_corner.tcl
# Analise estatica de timing pos-layout em um corner
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys PrimeTime
# Tecnologia: SAED32 RVT
#
# Chamado por sta/scripts/run_sta.sh, que define:
#   STA_CORNER  nome do corner da biblioteca (ex.: ss0p75v125c)
#   STA_SPEF    parasitas extraidos (Cmax ou Cmin)
#   STA_ECO     1 = gerar ECO de hold (sta/eco/hold_eco.tcl)
#
# Entradas:
#   pnr/output/filtro_pdm_pnr.v          netlist pos-layout
#   pnr/output/filtro_pdm.C*_25.spef     parasitas (finish.tcl)
#   pnr/output/filtro_pdm_pnr.sdc        restricoes exportadas pelo FC
# ============================================================

set CORNER $env(STA_CORNER)
set SPEF   $env(STA_SPEF)
set DB_DIR /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm
set REP    sta/reports/$CORNER

file mkdir $REP

# ------------------------------------------------------------
# 1. Biblioteca do corner e netlist
# ------------------------------------------------------------

set_app_var search_path [list . $DB_DIR]
set_app_var link_path   [list * saed32rvt_${CORNER}.db]

read_verilog pnr/output/filtro_pdm_pnr.v
current_design filtro_pdm
link_design


# ------------------------------------------------------------
# 2. Parasitas e restricoes
#
# Clock propagado: atrasos reais da arvore de clock do CTS.
# ------------------------------------------------------------

read_parasitics -format SPEF $SPEF
report_annotated_parasitics > $REP/parasitas.rpt

# SDC exportado pelo Fusion Compiler apos o CTS: alem das
# restricoes originais, contem a latencia do clock para os
# caminhos de E/S (set_clock_latency). Com o SDC original, as
# entradas eram lancadas no instante 0 enquanto o clock chega
# aos flip-flops ~0,12 ns depois, gerando falsas violacoes de
# hold nos caminhos scan_in/scan_en -> registradores.
read_sdc pnr/output/filtro_pdm_pnr.sdc

update_timing -full


# ------------------------------------------------------------
# 3. Relatorios
# ------------------------------------------------------------

report_global_timing > $REP/global_timing.rpt

report_timing -delay_type max -max_paths 10 \
    -significant_digits 3 > $REP/timing_max.rpt

report_timing -delay_type min -max_paths 10 \
    -significant_digits 3 > $REP/timing_min.rpt

report_constraint -all_violators > $REP/violadores.rpt

report_clock_timing -type skew > $REP/clock_skew.rpt

# ------------------------------------------------------------
# 4. ECO de hold (opcional)
#
# Insere buffers/celulas de atraso nos caminhos com hold
# violado e grava os comandos para o Fusion Compiler. A folga
# de setup e grande (> 50 ns) em todos os corners, portanto o
# atraso inserido nao compromete o setup.
# ------------------------------------------------------------

if {[info exists env(STA_ECO)] && $env(STA_ECO) eq "1"} {
    file mkdir sta/eco
    set BUFS {}
    foreach nome {DELLN1X2_RVT DELLN2X2_RVT NBUFFX2_RVT} {
        if {[sizeof_collection [get_lib_cells -quiet */$nome]] > 0} {
            lappend BUFS $nome
        }
    }
    puts "ECO de hold com: $BUFS"
    fix_eco_timing -type hold -methods {size_cell insert_buffer} \
        -buffer_list $BUFS
    report_global_timing > $REP/global_timing_apos_eco.rpt
    write_changes -format icc2tcl -output sta/eco/hold_eco.tcl
    puts "ECO gravado: sta/eco/hold_eco.tcl"
}

# Resumo no terminal
set pior_setup [get_attribute \
    [get_timing_paths -delay_type max] slack]
set pior_hold  [get_attribute \
    [get_timing_paths -delay_type min] slack]

puts ""
puts "=================================================="
puts "Corner     : $CORNER"
puts "Parasitas  : $SPEF"
puts "Pior setup : $pior_setup ns"
puts "Pior hold  : $pior_hold ns"
puts "Relatorios : $REP/"
puts "=================================================="

exit
