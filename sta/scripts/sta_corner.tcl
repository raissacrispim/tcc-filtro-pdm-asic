# ============================================================
# sta_corner.tcl
# Analise estatica de timing pos-layout (signoff)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys PrimeTime
# Tecnologia: SAED32 RVT
#
# Chamado por sta/scripts/run_sta.sh, que define:
#   STA_CORNER  corner da biblioteca (tt0p85v25c, ss0p75v125c,
#               ff0p95vn40c)
#   STA_SPEF    parasitas extraidos (Cmax ou Cmin)
#   STA_MODO    func  operacao normal (scan_en = 0)
#               scan  sem case analysis: deslocamento da cadeia
#                     (Q -> SI), transicoes de scan_en (-> SE) e
#                     scan_in, alem dos caminhos funcionais
#
# Restricoes: as originais do projeto (pnr/constraints/), com o
# clock propagado. As E/S sao referenciadas ao clock virtual
# vclk (clock da placa, ideal). Nenhuma margem e alterada aqui:
# incerteza de hold 0,10 ns e de setup 1,0 ns, do SDC.
#
# Historico (docs/auditoria_sta.md): a versao anterior reduzia a
# incerteza de hold para 0,05 ns e lia a latencia de E/S da
# coluna errada do report_clock_timing (transicao).
# ============================================================

set CORNER $env(STA_CORNER)
set SPEF   $env(STA_SPEF)
set MODO   $env(STA_MODO)
set DB_DIR /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm
set REP    sta/reports/${CORNER}_${MODO}

file mkdir $REP

# ------------------------------------------------------------
# 1. Biblioteca do corner, netlist e parasitas
# ------------------------------------------------------------

set_app_var search_path [list . $DB_DIR]
set_app_var link_path   [list * saed32rvt_${CORNER}.db]

read_verilog pnr/output/filtro_pdm_pnr.v
current_design filtro_pdm
link_design

read_parasitics -format SPEF $SPEF
report_annotated_parasitics > $REP/parasitas.rpt


# ------------------------------------------------------------
# 2. Restricoes e modo
# ------------------------------------------------------------

read_sdc pnr/constraints/filtro_pdm_physical.sdc
read_sdc pnr/constraints/filtro_pdm_dft.sdc

# Arvore de clock real (CTS); vclk permanece ideal
set_propagated_clock [get_clocks clk]

switch $MODO {
    func { set_case_analysis 0 [get_ports scan_en] }
    scan { }
    default { puts "ERRO: STA_MODO invalido: $MODO"; exit 1 }
}

update_timing -full


# ------------------------------------------------------------
# 3. Relatorios
# ------------------------------------------------------------

redirect $REP/check_timing.rpt  { check_timing -verbose }
redirect $REP/clocks.rpt        { report_clock -skew }
redirect $REP/case_analysis.rpt { report_case_analysis }
redirect $REP/clock_latency.rpt {
    report_clock_timing -type latency -nworst 20 -significant_digits 4
}
redirect $REP/clock_skew.rpt {
    report_clock_timing -type skew -significant_digits 4
}

report_global_timing -significant_digits 4 > $REP/global_timing.rpt

report_timing -delay_type max -max_paths 10 \
    -significant_digits 4 > $REP/timing_max.rpt
report_timing -delay_type min -max_paths 10 \
    -path_type full_clock_expanded -input_pins \
    -significant_digits 4 > $REP/timing_min.rpt

report_constraint -all_violators -significant_digits 4 \
    > $REP/violadores.rpt


# ------------------------------------------------------------
# 4. Contagem de violacoes por classe de caminho
#
# Um caminho por endpoint, 4 casas decimais: um slack que
# aparece como 0,00 com 2 casas e violado e contado.
# ------------------------------------------------------------

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

proc violadores {tipo arquivo} {
    set n {}
    set wns {}
    set f [open $arquivo w]
    foreach_in_collection t [get_timing_paths -delay_type $tipo \
            -nworst 1 -max_paths 100000 -slack_lesser_than 0.0] {
        set c [classe $t]
        set s [get_attribute $t slack]
        puts $f [format "%-28s %10.4f  %s <- %s" $c $s \
            [get_object_name [get_attribute $t endpoint]] \
            [get_object_name [get_attribute $t startpoint]]]
        dict incr n $c
        if {![dict exists $wns $c] || $s < [dict get $wns $c]} {
            dict set wns $c $s
        }
    }
    close $f
    return [list $n $wns]
}

lassign [violadores min $REP/hold_violadores.txt] n_hold wns_hold
lassign [violadores max $REP/setup_violadores.txt] n_setup wns_setup

proc folga {args} {
    set t [get_timing_paths {*}$args]
    if {[sizeof_collection $t] == 0} { return "sem caminho" }
    return [format "%.4f ns (%s -> %s)" [get_attribute $t slack] \
        [get_object_name [get_attribute $t startpoint]] \
        [get_object_name [get_attribute $t endpoint]]]
}

set entradas [remove_from_collection [all_inputs] [get_ports clk]]

set total_hold 0
dict for {c k} $n_hold { incr total_hold $k }
set total_setup 0
dict for {c k} $n_setup { incr total_setup $k }

puts ""
puts "=================================================="
puts "Corner     : $CORNER"
puts "Modo       : $MODO"
puts "Parasitas  : $SPEF"
puts "Pior setup : [folga -delay_type max]"
puts "Pior hold  : [folga -delay_type min]"
puts "Hold reg->reg  : [folga -delay_type min -from [all_registers] -to [all_registers]]"
puts "Hold entradas  : [folga -delay_type min -from $entradas]"
puts "Hold saidas    : [folga -delay_type min -to [all_outputs]]"
puts "Endpoints com setup violado: $total_setup"
puts "Endpoints com hold violado : $total_hold"
dict for {c k} $n_hold {
    puts [format "  hold %-28s %4d  WNS %.4f ns" $c $k [dict get $wns_hold $c]]
}
dict for {c k} $n_setup {
    puts [format "  setup %-27s %4d  WNS %.4f ns" $c $k [dict get $wns_setup $c]]
}
puts "Relatorios : $REP/"
puts "=================================================="

exit
