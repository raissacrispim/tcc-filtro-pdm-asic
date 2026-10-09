set sh_continue_on_error false

# ============================================================
# TCC - Filtro digital PDM CIC + FIR
# Power Planning - Synopsys Fusion Compiler
# Tecnologia: SAED32 RVT
#
# Entrada:  filtro_pdm/floorplan
# Saida:    filtro_pdm/power_plan_reproduzido
#
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
# Nao sobrescreve o checkpoint power_plan original.
# ============================================================

# ------------------------------------------------------------
# 1. Abrir o floorplan
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/floorplan

# ------------------------------------------------------------
# 2. Conectar logicamente VDD e VSS
# ------------------------------------------------------------

connect_pg_net -automatic

# ------------------------------------------------------------
# 3. Rails das standard cells em M1
# ------------------------------------------------------------

create_pg_std_cell_conn_pattern std_cell_rails \
    -layers {M1}

set_pg_strategy std_cell_rail_strategy \
    -core \
    -pattern {{name: std_cell_rails} {nets: {VDD VSS}}}

compile_pg \
    -strategies {std_cell_rail_strategy} \
    -tag pg_std_rails

# ------------------------------------------------------------
# 4. Anel de alimentacao M8/M9
# ------------------------------------------------------------

create_pg_ring_pattern core_ring \
    -horizontal_layer M8 \
    -vertical_layer M9 \
    -horizontal_width 0.20 \
    -vertical_width 0.20 \
    -horizontal_spacing 0.20 \
    -vertical_spacing 0.20

set_pg_strategy core_ring_strategy \
    -core \
    -pattern {{name: core_ring} {nets: {VDD VSS}} \
              {offset: {2 2}}}

compile_pg \
    -strategies {core_ring_strategy} \
    -tag pg_core_ring

# ------------------------------------------------------------
# 5. Straps verticais em M3
# ------------------------------------------------------------

create_pg_mesh_pattern core_straps \
    -layers { \
        {{vertical_layer: M3} \
         {width: minimum} \
         {spacing: interleaving} \
         {pitch: 40} \
         {offset: 20}} \
    }

set_pg_strategy core_strap_strategy \
    -core \
    -pattern {{name: core_straps} {nets: {VDD VSS}}} \
    -extension {{stop: innermost_ring}}

# ------------------------------------------------------------
# 6. Regra de vias
# ------------------------------------------------------------

set_pg_strategy_via_rule core_strap_via_rule \
    -via_rule { \
        {{{strategies: core_strap_strategy} {layers: M3}} \
         {{existing: std_conn} {layers: M1}} \
         {via_master: default}} \
        {{{strategies: core_strap_strategy} {layers: M3}} \
         {existing: ring} \
         {via_master: default}} \
        {{intersection: undefined} {via_master: NIL}} \
    }

# ------------------------------------------------------------
# 7. Gerar straps e conexoes
# ------------------------------------------------------------

compile_pg \
    -strategies {core_strap_strategy} \
    -via_rule core_strap_via_rule \
    -tag pg_core_strap_vias

# ------------------------------------------------------------
# 8. Terminais fisicos VDD e VSS
# Coordenadas recuperadas do checkpoint original
# ------------------------------------------------------------

create_terminal \
    -port [get_ports VDD] \
    -boundary {{119.000 231.032} {121.000 231.232}} \
    -layer M8 \
    -name VDD_TOP

create_terminal \
    -port [get_ports VSS] \
    -boundary {{119.000 231.432} {121.000 231.632}} \
    -layer M8 \
    -name VSS_TOP

# ------------------------------------------------------------
# 9. Relatorios das estrategias
# ------------------------------------------------------------

report_pg_patterns
report_pg_strategies
report_pg_strategy_via_rules

# ------------------------------------------------------------
# 10. Verificacoes da rede de alimentacao
# ------------------------------------------------------------

check_pg_drc
check_pg_connectivity

# ------------------------------------------------------------
# 11. Salvar checkpoint de reproducao
# ------------------------------------------------------------

save_block -label power_plan_reproduzido

puts "Power planning: script executado ate o final."
puts "Verifique os relatorios e compare com o checkpoint original."

