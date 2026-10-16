# ============================================================
# write_sdf_gls.tcl
# SDF para a simulacao pos-layout (VCS)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys PrimeTime
# Tecnologia: SAED32 RVT
#
# Chamado por sta/scripts/run_sdf_gls.sh.
#
# Por que o SDF vem do PrimeTime e nao do write_sdf do FC
# (docs/auditoria_sdf.md):
#
# 1. O FC escreve os bits das portas de barramento como
#    identificadores escapados (y_out\[18\]). Para o VCS isso e
#    um nome escalar, inexistente na netlist, que declara o
#    barramento y_out[18:0]: 19 erros SDFCOM_PONF e as
#    interconexoes dessas portas nao sao anotadas. O write_sdf
#    do FC nao tem opcao para mudar esse formato; no PrimeTime,
#    -context verilog escreve y_out[18] (bit do barramento).
# 2. O FC grava 2 casas decimais (10 ps): 24.705 das 24.911
#    interconexoes viram 0,00. Aqui sao 3 casas (1 ps).
# 3. SETUPHOLD/RECREM correspondem as verificacoes $setuphold e
#    $recrem dos modelos Verilog da SAED32.
#
# Mesmo corner e parasitas do SDF do FC: tt0p85v25c, Cmax.
# O SDC do FC deixa o clock dos registradores propagado
# (set_propagated_clock na porta clk); o aviso UITE-305 refere-se
# apenas a latencia de E/S do objeto clock e nao altera o SDF.
#
# As interconexoes das 21 portas de saida (ate 0,004 ns) nao sao
# escritas (padrao do PrimeTime): o VCS nao as anota como
# interconexao na fronteira do DUT (SDFCOM_UHICD). Para inclui-las
# use SDF_SAIDAS=1 em run_sdf_gls.sh.
# ============================================================

set DB_DIR /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm
set REP    sta/reports/sdf_gls
set SDF    pnr/output/filtro_pdm_pnr_pt.sdf

file mkdir $REP

set_app_var search_path [list . $DB_DIR]
set_app_var link_path   [list * saed32rvt_tt0p85v25c.db]

read_verilog pnr/output/filtro_pdm_pnr.v
current_design filtro_pdm
link_design

read_parasitics -format SPEF pnr/output/filtro_pdm.Cmax_25.spef
read_sdc pnr/output/filtro_pdm_pnr.sdc
update_timing -full

report_annotated_parasitics > $REP/parasitas.rpt
report_annotated_parasitics -list_not_annotated -max_nets 1000 \
    > $REP/nao_anotadas.rpt

set OPCOES [list -version 3.0 -context verilog -significant_digits 3 \
                 -include {SETUPHOLD RECREM} -input_port_nets]
if {[info exists env(SDF_SAIDAS)] && $env(SDF_SAIDAS) eq "1"} {
    lappend OPCOES -output_port_nets
}

write_sdf {*}$OPCOES $SDF

puts "SDF para simulacao: $SDF"
exit
