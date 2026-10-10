set sh_continue_on_error false

# ============================================================
# route.tcl
# Roteamento global, track assignment e detalhado
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT
#
# Entrada:  filtro_pdm/cts
# Saida:    filtro_pdm/route
#
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
# ============================================================

file mkdir pnr/reports/route

# ------------------------------------------------------------
# 1. Abrir o checkpoint do CTS
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/cts


# ------------------------------------------------------------
# 2. Camadas de roteamento de sinais
#
# Sinais em M1-M8. M9 e reservada ao anel de alimentacao
# (vertical) e MRDL e a camada de redistribuicao para pads
# (largura minima de 2 um), inadequada para sinais.
# ------------------------------------------------------------

set_ignored_layers \
    -min_routing_layer M1 \
    -max_routing_layer M8

report_ignored_layers


# ------------------------------------------------------------
# 3. Verificacoes antes do roteamento
# ------------------------------------------------------------

check_routability > pnr/reports/route/check_routability.rpt


# ------------------------------------------------------------
# 4. Roteamento
#
# route_auto: global route + track assignment + detail route
# route_opt:  otimizacao de timing com parasitas extraidos
# ------------------------------------------------------------

route_auto

route_opt


# ------------------------------------------------------------
# 5. Conexao PG das celulas inseridas na otimizacao
# ------------------------------------------------------------

connect_pg_net -automatic


# ------------------------------------------------------------
# 6. Verificacoes e relatorios
# ------------------------------------------------------------

check_routes > pnr/reports/route/check_routes.rpt

report_qor > pnr/reports/route/qor.rpt

report_timing -delay_type max -max_paths 10 \
    > pnr/reports/route/timing_max.rpt

report_timing -delay_type min -max_paths 10 \
    > pnr/reports/route/timing_min.rpt


# ------------------------------------------------------------
# 7. Salvar checkpoint
# ------------------------------------------------------------

save_block -label route

puts "Roteamento: script executado ate o final."
puts "Confira DRC de roteamento em pnr/reports/route/check_routes.rpt"
