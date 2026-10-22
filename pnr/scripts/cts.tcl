set sh_continue_on_error false

# ============================================================
# cts.tcl
# Sintese da arvore de clock (CTS)
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT
#
# Entrada:  filtro_pdm/place
# Saida:    filtro_pdm/cts
# ============================================================

file mkdir pnr/reports/cts

# ------------------------------------------------------------
# 1. Abrir o checkpoint do placement
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/place


# ------------------------------------------------------------
# 2. Ajustes de otimizacao
# ------------------------------------------------------------

# Transicao maxima (tambem definida no SDC fisico; reaplicada
# aqui porque o bloco foi criado antes dessa restricao).
set_max_transition 0.50 [current_design]

# Camadas de roteamento de sinais e do clock: M2-M8
# M1: somente pinos e rails das celulas. Trechos curtos de M1
#     roteados com 0,05 um violam a regra M1.W.2.1 do DRC
#     (largura minima de 0,06 um junto a M1 largo).
# M9: anel de alimentacao; MRDL: redistribuicao para pads.
set_ignored_layers -min_routing_layer M2 -max_routing_layer M8

# Modo "hard": a camada minima vale tambem para o acesso aos
# pinos. No modo padrao (allow_pin_connection) o roteador ainda
# usa ate ~5 um de M1 para chegar aos pinos, o que deixou 10
# violacoes M1.W.2.1 no DRC. Os pinos em M1 sao acessados por
# vias VIA12 a partir de M2.
foreach {opcao valor} {
    route.common.global_min_layer_mode hard
    route.common.net_min_layer_mode    hard
} {
    if {[catch {set_app_options -name $opcao -value $valor} msg]} {
        puts "Aviso: opcao $opcao nao aplicada ($msg)"
    } else {
        puts "Opcao $opcao = $valor"
    }
}

# Permite o uso das celulas TIE (TIEH/TIEL) caso a otimizacao
# gere redes constantes (aviso OPT-200 no placement).
set_lib_cell_purpose -include optimization [get_lib_cells */TIE*]


# ------------------------------------------------------------
# Hold nos corners tipico e rapido
#
# Os cenarios func_ff, scan_tt e scan_ff (timing_setup.tcl)
# fazem o clock_opt corrigir o hold de cada corner/modo com a
# incerteza do SDC (0,10 ns). Substitui o aumento artificial da
# incerteza para 0,25 ns no corner tipico usado antes.
# ------------------------------------------------------------

report_scenarios > pnr/reports/cts/scenarios.rpt


# ------------------------------------------------------------
# 3. Verificacoes antes do CTS
# ------------------------------------------------------------

check_clock_trees > pnr/reports/cts/check_clock_trees.rpt


# ------------------------------------------------------------
# 4. CTS, roteamento do clock e otimizacao
#
# clock_opt executa:
#   - construcao da arvore (buffers de clock)
#   - roteamento das redes de clock
#   - otimizacao com clock propagado, incluindo hold
# ------------------------------------------------------------

source pnr/scripts/vclk_ideal.tcl

# Margem de capacitancia nas redes de clock
#
# A arvore e construida antes do roteamento final; o fio
# adicionado depois deixou uma rede de clock (ZCTSNET_1) com
# 65,5 fF para o limite de 64 fF do inversor. O ECO de max cap
# do finish.tcl nao altera celulas de clock (ver finish.tcl),
# entao a margem e dada aqui: 56 fF (~12%) nas redes de clock,
# em todos os cenarios. As redes de dados mantem o limite da
# biblioteca.
set CAP_MAX_CLOCK 56
set cenario_atual [get_object_name [current_scenario]]
foreach_in_collection sc [get_scenarios *] {
    current_scenario $sc
    if {[catch {set_max_capacitance $CAP_MAX_CLOCK -clock_path \
            [get_clocks clk]} msg]} {
        puts "Aviso: margem de capacitancia do clock nao aplicada ($msg)"
    }
}
current_scenario $cenario_atual
puts "Capacitancia maxima nas redes de clock: $CAP_MAX_CLOCK fF"

clock_opt

# O clock_opt pode ajustar de novo a latencia do vclk
vclk_ideal


# ------------------------------------------------------------
# 5. Conexao PG das celulas inseridas
# ------------------------------------------------------------

connect_pg_net -automatic

check_legality


# ------------------------------------------------------------
# 6. Relatorios
#
# Apos o CTS a analise de hold passa a ser significativa.
# ------------------------------------------------------------

report_clock_qor > pnr/reports/cts/clock_qor.rpt
report_qor       > pnr/reports/cts/qor.rpt

report_timing -delay_type max -max_paths 10 \
    > pnr/reports/cts/timing_max.rpt

report_timing -delay_type min -max_paths 10 \
    > pnr/reports/cts/timing_min.rpt

report_utilization > pnr/reports/cts/utilization.rpt


# ------------------------------------------------------------
# 7. Salvar checkpoint
#
# Remove o checkpoint de uma execucao anterior, se existir.
# ------------------------------------------------------------

catch {remove_blocks -force filtro_pdm/cts}

save_block -label cts

puts "CTS: script executado ate o final."
puts "Relatorios em pnr/reports/cts/"
