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
# Vias redundantes desativadas
#
# Na primeira execucao, a troca de vias simples por vias
# duplas (VIA12SQ_1x2) gerou 41 violacoes "Off-grid" em VIA1:
# essa variante de via nao fica alinhada a grade do SAED32.
# Os nomes das opcoes variam entre versoes; opcoes inexistentes
# sao apenas informadas, sem interromper o script.
# ------------------------------------------------------------

foreach {opcao valor} {
    route.common.concurrent_redundant_via_mode           off
    route.common.eco_route_concurrent_redundant_via_mode off
    route.common.post_detail_route_redundant_via_insertion off
    route.common.post_eco_route_redundant_via_insertion  off
} {
    if {[catch {set_app_options -name $opcao -value $valor} msg]} {
        puts "Aviso: opcao $opcao nao aplicada ($msg)"
    } else {
        puts "Opcao $opcao = $valor"
    }
}


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

# Segunda passada: corrige violacoes residuais de capacitancia
# maxima e hold deixadas pela primeira otimizacao
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


report_constraints -all_violators \
    > pnr/reports/route/violadores.rpt


# ------------------------------------------------------------
# 7. Salvar checkpoint
#
# Remove o checkpoint de uma execucao anterior, se existir.
# ------------------------------------------------------------

catch {remove_blocks -force filtro_pdm/route}

save_block -label route

puts "Roteamento: script executado ate o final."
puts "Confira DRC de roteamento em pnr/reports/route/check_routes.rpt"
