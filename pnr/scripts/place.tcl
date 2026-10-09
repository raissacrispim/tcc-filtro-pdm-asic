set sh_continue_on_error false

# ============================================================
# place.tcl
# Posicionamento das standard cells
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT
#
# Entrada:  filtro_pdm/power_plan_reproduzido
# Saida:    filtro_pdm/place
#
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
# ============================================================

file mkdir pnr/reports/place

# ------------------------------------------------------------
# 1. Abrir o checkpoint do power plan
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/power_plan_reproduzido


# ------------------------------------------------------------
# 2. Configuracao de timing e parasitas
# ------------------------------------------------------------

source pnr/scripts/timing_setup.tcl


# ------------------------------------------------------------
# 3. Posicionamento dos pinos de I/O
#
# Sem pad ring: os pinos ficam na borda do bloco.
# Camadas intermediarias, abaixo do anel M8/M9.
# ------------------------------------------------------------

set_block_pin_constraints \
    -self \
    -allowed_layers {M3 M4 M5 M6}

place_pins -self

report_pin_placement > pnr/reports/place/pin_placement.rpt


# ------------------------------------------------------------
# 4. Opcoes de posicionamento
# ------------------------------------------------------------

# Projeto sem scan chain (sem DFT)
set_app_options \
    -name place.coarse.continue_on_missing_scandef \
    -value true


# ------------------------------------------------------------
# 5. Verificacoes antes do posicionamento
# ------------------------------------------------------------

check_design \
    -checks pre_placement_stage \
    -log_file pnr/reports/place/check_pre_placement.log


# ------------------------------------------------------------
# 6. Posicionamento com otimizacao
# ------------------------------------------------------------

place_opt


# ------------------------------------------------------------
# 7. Conexao PG das celulas posicionadas
# ------------------------------------------------------------

connect_pg_net -automatic

check_legality


# ------------------------------------------------------------
# 8. Relatorios
# ------------------------------------------------------------

report_utilization   > pnr/reports/place/utilization.rpt
report_qor           > pnr/reports/place/qor.rpt
report_congestion    > pnr/reports/place/congestion.rpt

report_timing -delay_type max -max_paths 10 \
    > pnr/reports/place/timing_max.rpt

report_timing -delay_type min -max_paths 10 \
    > pnr/reports/place/timing_min.rpt

check_pg_connectivity > pnr/reports/place/pg_connectivity.rpt


# ------------------------------------------------------------
# 9. Salvar checkpoint
# ------------------------------------------------------------

save_block -label place

puts "Placement: script executado ate o final."
puts "Relatorios em pnr/reports/place/"
