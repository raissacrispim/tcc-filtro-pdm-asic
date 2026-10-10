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
#
# Cada terminal (2 um de largura) e criado sobre o segmento
# horizontal superior do anel da rede, em M8, no centro do
# segmento. As coordenadas sao obtidas do proprio anel, e nao
# fixadas no script, pois o Fusion Compiler ajusta a altura do
# core para um numero inteiro de linhas de celulas.
# ------------------------------------------------------------

proc cria_terminal_no_anel {rede nome} {

    set shapes [get_shapes -quiet \
        -filter "net.name == $rede && layer.name == M8"]

    if {[sizeof_collection $shapes] == 0} {
        puts "ERRO: nenhum shape de $rede em M8 (anel nao encontrado)."
        return -code error
    }

    # Segmentos longos (anel) e, entre eles, o mais alto
    set melhor {}
    set y_max -1.0e9

    foreach_in_collection s $shapes {
        set bb  [get_attribute $s bbox]
        set llx [lindex $bb 0 0]
        set lly [lindex $bb 0 1]
        set urx [lindex $bb 1 0]
        set ury [lindex $bb 1 1]

        if {($urx - $llx) < 100.0} {
            continue
        }

        if {$ury > $y_max} {
            set y_max $ury
            set melhor [list $llx $lly $urx $ury]
        }
    }

    if {[llength $melhor] == 0} {
        puts "ERRO: segmento superior do anel de $rede nao encontrado."
        return -code error
    }

    lassign $melhor llx lly urx ury
    set xc [expr {($llx + $urx) / 2.0}]

    set limites [list \
        [list [expr {$xc - 1.0}] $lly] \
        [list [expr {$xc + 1.0}] $ury]]

    create_terminal \
        -port [get_ports $rede] \
        -boundary $limites \
        -layer M8 \
        -name $nome

    puts "Terminal $nome criado em $limites (M8)"
}

cria_terminal_no_anel VDD VDD_TOP
cria_terminal_no_anel VSS VSS_TOP

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
#
# Remove o checkpoint de uma execucao anterior, se existir.
# ------------------------------------------------------------

catch {remove_blocks -force filtro_pdm/power_plan_reproduzido}

save_block -label power_plan_reproduzido

puts "Power planning: script executado ate o final."
puts "Verifique os relatorios e compare com o checkpoint original."

