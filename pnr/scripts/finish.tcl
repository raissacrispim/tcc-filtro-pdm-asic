set sh_continue_on_error false

# ============================================================
# finish.tcl
# Finalizacao, relatorios finais e exportacao
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT
#
# Entrada:  filtro_pdm/route
# Saida:    filtro_pdm/finish
#           pnr/output/ (GDSII, netlists, SDF, SPEF, DEF)
#
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
#
# CONFERIR NO SERVIDOR:
#   ls /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/gds/
# e ajustar STDCELL_GDS abaixo.
# ============================================================

set STDCELL_GDS \
    /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/gds/saed32nm_rvt_1p9m.gds

file mkdir pnr/reports/finish
file mkdir pnr/output

# ------------------------------------------------------------
# 1. Abrir o checkpoint do roteamento
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/route


# ------------------------------------------------------------
# 2. Celulas de preenchimento (filler)
#
# Preenchem os espacos vazios das linhas de celulas, dando
# continuidade aos poços (well) e aos rails de alimentacao.
# Ordem decrescente de largura.
# ------------------------------------------------------------

set FILLERS [get_lib_cells */SHFILL*_RVT]

if {[sizeof_collection $FILLERS] == 0} {
    puts "ERRO: celulas SHFILL*_RVT nao encontradas na biblioteca."
    return -code error
}

create_stdcell_fillers -lib_cells $FILLERS

connect_pg_net -automatic

remove_stdcell_fillers_with_violation


# ------------------------------------------------------------
# 3. Verificacoes fisicas internas do Fusion Compiler
#
# Verificacao preliminar. O signoff de DRC e LVS e feito
# depois no IC Validator, a partir do GDSII.
# ------------------------------------------------------------

check_legality        > pnr/reports/finish/legality.rpt
check_routes          > pnr/reports/finish/check_routes.rpt
check_pg_drc          > pnr/reports/finish/pg_drc.rpt
check_pg_connectivity > pnr/reports/finish/pg_connectivity.rpt
check_lvs             > pnr/reports/finish/check_lvs.rpt


# ------------------------------------------------------------
# 4. Relatorios finais
# ------------------------------------------------------------

report_qor         > pnr/reports/finish/qor.rpt
report_utilization > pnr/reports/finish/utilization.rpt
report_power       > pnr/reports/finish/power.rpt
report_clock_qor   > pnr/reports/finish/clock_qor.rpt

report_timing -delay_type max -max_paths 10 \
    > pnr/reports/finish/timing_max.rpt

report_timing -delay_type min -max_paths 10 \
    > pnr/reports/finish/timing_min.rpt

report_design -floorplan > pnr/reports/finish/design.rpt


# ------------------------------------------------------------
# 5. Salvar checkpoint final
# ------------------------------------------------------------

save_block -label finish


# ------------------------------------------------------------
# 6. Exportacao
# ------------------------------------------------------------

# Netlist para simulacao pos-layout (sem PG e sem fillers)
write_verilog \
    -exclude {pg_objects physical_only_cells leaf_module_declarations} \
    pnr/output/filtro_pdm_pnr.v

# Netlist para LVS (com conexoes VDD/VSS)
write_verilog \
    -exclude {physical_only_cells leaf_module_declarations} \
    pnr/output/filtro_pdm_lvs.v

# Atrasos para simulacao com back-annotation no VCS
write_sdf pnr/output/filtro_pdm_pnr.sdf

# Parasitas extraidos (SPEF)
write_parasitics -output pnr/output/filtro_pdm

# Restricoes finais
write_sdc -output pnr/output/filtro_pdm_pnr.sdc

# Descricao fisica (DEF)
write_def pnr/output/filtro_pdm.def

# GDSII com o layout das standard cells incorporado
write_gds \
    -hierarchy all \
    -long_names \
    -merge_files $STDCELL_GDS \
    pnr/output/filtro_pdm.gds

puts "Finalizacao: script executado ate o final."
puts "GDSII: pnr/output/filtro_pdm.gds"
