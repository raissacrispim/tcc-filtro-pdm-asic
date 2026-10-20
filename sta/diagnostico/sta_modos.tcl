# ============================================================
# sta_modos.tcl
# STA de diagnostico: hold/setup por modo e referencia de E/S
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys PrimeTime
#
# Somente leitura: nao altera netlist, SDC nem layout.
# Chamado por sta/diagnostico/run_diagnostico.sh, que define:
#   STA_CORNER  tt0p85v25c | ss0p75v125c | ff0p95vn40c
#   STA_SPEF    parasitas (Cmax ou Cmin)
#   STA_MODO    func  (scan_en = 0: caminhos D, funcionais)
#               shift (scan_en = 1: deslocamento da cadeia, Q -> SI)
#   STA_REF     referencia temporal dos caminhos de E/S:
#               fc    latencia de E/S do SDC do FC (0,235/0,265 ns,
#                     estimativa do corner tipico)
#               porta clock dos circuitos externos = clock na porta
#                     clk (latencia de E/S nula)
#               real  latencia real dos registradores neste corner
#                     (min/max sobre todos os pinos de clock)
#
# A incerteza de hold e a do SDC (0,10 ns), sem alteracao.
# ============================================================

set CORNER $env(STA_CORNER)
set SPEF   $env(STA_SPEF)
set MODO   $env(STA_MODO)
set REF    $env(STA_REF)
set DB_DIR /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm
set REP    sta/diagnostico/reports/${CORNER}_${MODO}_${REF}
file mkdir $REP

set_app_var search_path [list . $DB_DIR]
set_app_var link_path   [list * saed32rvt_${CORNER}.db]
set_app_var timing_save_pin_arrival_and_required true

read_verilog pnr/output/filtro_pdm_pnr.v
current_design filtro_pdm
link_design
read_parasitics -format SPEF $SPEF
read_sdc pnr/output/filtro_pdm_pnr.sdc

switch $MODO {
    func  { set_case_analysis 0 [get_ports scan_en] }
    shift { set_case_analysis 1 [get_ports scan_en] }
    default { puts "ERRO: STA_MODO invalido: $MODO"; exit 1 }
}

# Latencia real do clock nos registradores (arrival no pino CLK)
update_timing -full
set lat_min 1e9
set lat_max -1e9
foreach_in_collection p [all_registers -clock_pins] {
    foreach a {min_rise_arrival max_rise_arrival} {
        set v [get_attribute -quiet $p $a]
        if {$v eq "" || $v eq "INFINITY"} { continue }
        if {$v < $lat_min} { set lat_min $v }
        if {$v > $lat_max} { set lat_max $v }
    }
}
puts "LATENCIA_REAL $CORNER: min $lat_min max $lat_max ns"
redirect $REP/clock_latency.rpt {
    report_clock_timing -type latency -nworst 20 -significant_digits 4
}

switch $REF {
    fc    { }
    porta { remove_clock_latency [get_clocks clk] }
    real  {
        set_clock_latency -min $lat_min [get_clocks clk]
        set_clock_latency -max $lat_max [get_clocks clk]
    }
    default { puts "ERRO: STA_REF invalido: $REF"; exit 1 }
}
update_timing -full

redirect $REP/check_timing.rpt     { check_timing -verbose }
redirect $REP/case_analysis.rpt    { report_case_analysis }
redirect $REP/clock.rpt            { report_clock }
redirect $REP/incerteza.rpt        { report_clock -skew }
redirect $REP/crpr.rpt {
    puts "timing_remove_clock_reconvergence_pessimism = [get_app_var timing_remove_clock_reconvergence_pessimism]"
}

# Classificacao dos endpoints com hold violado (1 caminho por endpoint)
proc classe {t} {
    set ep [get_attribute $t endpoint]
    set sp [get_attribute $t startpoint]
    set epn [get_object_name $ep]
    if {[get_attribute $ep object_class] eq "port"} { return "reg->saida" }
    if {[get_attribute $sp object_class] eq "port"} {
        return "entrada([get_object_name $sp])->reg"
    }
    if {[string match */SI $epn]} { return "reg->reg(SI)" }
    if {[string match */SE $epn]} { return "reg->reg(SE)" }
    return "reg->reg(D)"
}

set n {}; set wns {}; set tns {}; set pior {}
set f [open $REP/hold_violadores.txt w]
foreach_in_collection t [get_timing_paths -delay_type min -nworst 1 \
        -max_paths 100000 -slack_lesser_than 0.0] {
    set c [classe $t]
    set s [get_attribute $t slack]
    puts $f [format "%-28s %10.4f  %s <- %s" $c $s \
        [get_object_name [get_attribute $t endpoint]] \
        [get_object_name [get_attribute $t startpoint]]]
    dict incr n $c
    if {![dict exists $wns $c] || $s < [dict get $wns $c]} {
        dict set wns $c $s
        dict set pior $c [get_object_name [get_attribute $t endpoint]]
    }
    dict set tns $c [expr {([dict exists $tns $c] ? [dict get $tns $c] : 0) + $s}]
}
close $f

set setup [get_attribute [get_timing_paths -delay_type max] slack]
set hold  [get_attribute [get_timing_paths -delay_type min] slack]

puts ""
puts "RESUMO $CORNER modo=$MODO ref=$REF  pior setup=[format %.4f $setup]  pior hold=[format %.4f $hold]"
if {[dict size $n] == 0} {
    puts "RESUMO   nenhum endpoint com hold violado"
}
dict for {c k} $n {
    puts [format "RESUMO   %-28s endpoints=%4d  WNS=%8.4f  TNS=%9.4f  pior=%s" \
        $c $k [dict get $wns $c] [dict get $tns $c] [dict get $pior $c]]
    redirect -append $REP/hold_piores.rpt {
        report_timing -delay_type min -to [dict get $pior $c] \
            -path_type full_clock_expanded -input_pins \
            -significant_digits 4
    }
}
exit
