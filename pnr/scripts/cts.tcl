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
#
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
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

# Camadas de roteamento de sinais e do clock: M1-M8
# (M9: anel de alimentacao; MRDL: redistribuicao para pads)
set_ignored_layers -min_routing_layer M1 -max_routing_layer M8

# Permite o uso das celulas TIE (TIEH/TIEL) caso a otimizacao
# gere redes constantes (aviso OPT-200 no placement).
set_lib_cell_purpose -include optimization [get_lib_cells */TIE*]


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

clock_opt


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
