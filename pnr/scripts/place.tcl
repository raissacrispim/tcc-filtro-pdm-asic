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
# 4. Cadeia de scan (DFT)
#
# O scandef gerado na sintese descreve a cadeia de scan.
# O place_opt reordena a cadeia conforme a posicao fisica dos
# flip-flops, reduzindo o comprimento das conexoes de scan.
# ------------------------------------------------------------

read_def synth/netlist/filtro_pdm_syn.scandef

report_scan_chains > pnr/reports/place/scan_chains.rpt


# ------------------------------------------------------------
# 5. Verificacoes antes do posicionamento
# ------------------------------------------------------------

check_design \
    -checks pre_placement_stage \
    -log_file pnr/reports/place/check_pre_placement.log


# ------------------------------------------------------------
# 5b. Um driver por porta de saida
#
# Na sintese, scan_out e y_out[18] tem inversores proprios
# (U804 e U805), ambos alimentados por n732 (y_out[18] do FIR
# invertido): o DFT usou o registrador de saida do FIR como
# ultima celula da cadeia e criou a porta scan_out dedicada.
# A high-fanout synthesis do place_opt fundiu os dois inversores
# (logicamente equivalentes) em HFSINV_66_144, ligado as duas
# portas ("assign y_out[18] = scan_out" na netlist). No layout
# uma unica rede chegava a dois pinos de nomes diferentes:
# violacao text_net:text_short no LVS (docs/auditoria_final.md).
#
# Os drivers de cada porta de saida podem ser redimensionados,
# mas nao removidos nem fundidos (size_only). A opcao do FC que
# elimina assign entre portas fica ligada como segunda protecao.
# ------------------------------------------------------------

# Celulas folha que dirigem cada porta de saida (atravessando
# a hierarquia de u_fir, quando a porta vem de dentro dele)
set DRIVERS_SAIDA {}
foreach_in_collection porta [get_ports -filter "direction==out"] {
    set rede [get_nets -quiet -of_objects $porta]
    if {[catch {set pinos [get_pins -quiet -leaf -of_objects $rede \
            -filter "direction==out"]}]} {
        set pinos [get_pins -quiet -of_objects $rede -filter "direction==out"]
    }
    foreach_in_collection p $pinos {
        set c [get_cells -quiet -of_objects $p -filter "is_hierarchical==false"]
        if {[sizeof_collection $c] > 0} {
            append_to_collection -unique DRIVERS_SAIDA $c
        }
    }
}
if {[catch {set_size_only $DRIVERS_SAIDA true} msg] &&
    [catch {set_size_only $DRIVERS_SAIDA} msg]} {
    puts "ERRO: set_size_only nao aplicado ($msg)"
    return -code error
}
puts "Drivers das portas de saida protegidos (size_only): [sizeof_collection $DRIVERS_SAIDA]"
puts "  inclui: [get_object_name [filter_collection $DRIVERS_SAIDA {name==U804 || name==U805}]]"

if {[catch {set_app_options -name opt.port.eliminate_verilog_assign \
        -value true} msg]} {
    puts "Aviso: opt.port.eliminate_verilog_assign nao aplicada ($msg)"
} else {
    puts "Opcao opt.port.eliminate_verilog_assign = true"
}

# Conferencia antes da otimizacao: cada porta de saida em uma rede propria
proc portas_saida_compartilhadas {} {
    set vistas {}
    set repetidas {}
    foreach_in_collection porta [get_ports -filter "direction==out"] {
        set r [get_object_name [get_nets -quiet -of_objects $porta]]
        if {[dict exists $vistas $r]} {
            lappend repetidas "[dict get $vistas $r] e [get_object_name $porta] (rede $r)"
        } else {
            dict set vistas $r [get_object_name $porta]
        }
    }
    return $repetidas
}


# ------------------------------------------------------------
# 6. Posicionamento com otimizacao
# ------------------------------------------------------------

place_opt

set compartilhadas [portas_saida_compartilhadas]
if {[llength $compartilhadas] > 0} {
    puts "ERRO: portas de saida ligadas a mesma rede apos o place_opt:"
    foreach c $compartilhadas { puts "  $c" }
    return -code error
}
puts "Portas de saida: uma rede por porta (sem curto entre pinos)"


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
