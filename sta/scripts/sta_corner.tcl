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

# Incerteza de hold apos o CTS
#
# O SDC (0,10 ns) usa a margem preliminar, anterior ao CTS:
# ela cobre o skew estimado da arvore de clock, o jitter e uma
# margem. Com o clock propagado, o skew real ja esta nos
# atrasos calculados; a incerteza de signoff passa a cobrir so
# o jitter e a margem: 0,05 ns. O setup mantem 1,0 ns.
set_clock_uncertainty -hold 0.05 [get_clocks clk]

# Latencia de clock dos caminhos de E/S por corner
#
# O SDC do FC fixa a latencia de E/S com os valores do corner
# tipico (0,17-0,21 ns). No corner rapido a arvore de clock
# real e mais curta (~0,07 ns), e manter o valor tipico cria
# falsas violacoes de hold nas saidas (y_out, valid_out,
# scan_out). A latencia de E/S e recalculada com a latencia
# real dos registradores neste corner.
# Latencias lidas do report_clock_timing (todos os pinos de
# clock dos registradores): menor no modo early, maior no late.
proc latencias_clock {modo} {
    set valores {}
    if {[catch {redirect -variable txt {report_clock_timing \
            -type latency $modo -nworst 100000 -significant_digits 4}}]} {
        redirect -variable txt {report_clock_timing \
            -type latency -nworst 100000 -significant_digits 4}
    }
    foreach linha [split $txt "\n"] {
        if {[regexp {^\s*\S+/CLK\s+(-?[0-9]+\.[0-9]+)} $linha -> v]} {
            lappend valores $v
        }
    }
    return [lsort -real $valores]
}
set lat_min ""
set lat_max ""
set cedo  [latencias_clock -early]
set tarde [latencias_clock -late]
if {[llength $cedo] > 0}  { set lat_min [lindex $cedo 0] }
if {[llength $tarde] > 0} { set lat_max [lindex $tarde end] }
if {$lat_min ne "" && $lat_max ne ""} {
    puts "Latencia de E/S no corner $CORNER: min $lat_min / max $lat_max ns"
    set_clock_latency -min $lat_min [get_clocks clk]
    set_clock_latency -max $lat_max [get_clocks clk]
} else {
    puts "Aviso: latencia dos registradores nao obtida; mantida a do SDC do FC"
}

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
