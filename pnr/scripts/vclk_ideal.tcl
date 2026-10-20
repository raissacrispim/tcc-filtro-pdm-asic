# ============================================================
# vclk_ideal.tcl
# Mantem o clock virtual das E/S (vclk) ideal, com latencia 0
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
#
# Usado por cts.tcl, route.tcl e finish.tcl.
#
# O vclk representa o clock da placa nos circuitos externos
# (pnr/constraints/filtro_pdm_physical.sdc). Durante o CTS o
# FC ajustou a latencia desse clock ideal como "useful skew"
# (set_clock_latency 0.112478 [get_clocks vclk], -origin
# useful_skew, no SDC exportado). Com isso o otimizador via as
# entradas chegando 0,11 ns mais tarde e nao corrigia o hold de
# rst/scan_en, que o PrimeTime (latencia 0, SDC original)
# acusava. O ajuste e desligado e a latencia e removida em
# todos os cenarios.
# ============================================================

foreach {opcao valor} {
    ccd.adjust_io_clock_latency false
} {
    if {[catch {set_app_options -name $opcao -value $valor} msg]} {
        puts "Aviso: opcao $opcao nao aplicada ($msg)"
    } else {
        puts "Opcao $opcao = $valor"
    }
}

proc vclk_ideal {} {
    set atual [get_object_name [current_scenario]]
    foreach_in_collection sc [get_scenarios *] {
        current_scenario $sc
        catch {remove_clock_latency [get_clocks vclk]}
    }
    current_scenario $atual
    puts "vclk: latencia removida em todos os cenarios (clock ideal)"
}

vclk_ideal
