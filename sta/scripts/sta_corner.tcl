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
#   pnr/constraints/*.sdc                mesmas restricoes do fluxo
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

read_sdc pnr/constraints/filtro_pdm_physical.sdc
read_sdc pnr/constraints/filtro_pdm_dft.sdc

set_propagated_clock [all_clocks]

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
