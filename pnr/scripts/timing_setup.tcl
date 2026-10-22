# ============================================================
# timing_setup.tcl
# Configuracao de timing e parasitas para o P&R
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 1P9M - RVT
#
# Chamado por place.tcl (uma unica vez, apos o power plan).
# As configuracoes ficam salvas no bloco e valem para as
# etapas seguintes (CTS, roteamento e finalizacao).
#
# Biblioteca de referencia: saed32rvt_base_frame_timing.ndm
# (definida em setup.tcl), com visoes fisica e de timing.
# ============================================================

# ------------------------------------------------------------
# 1. Arquivos de extracao de parasitas (TLU+)
#
# Procurados automaticamente em tech/starrc/ e subpastas.
# ------------------------------------------------------------

set STARRC_DIR /Tools/PDK/SAED32/EDK_Digital/tech/starrc

proc procura_arquivo {dir padrao} {
    set achados [glob -nocomplain \
        $dir/$padrao $dir/*/$padrao $dir/*/*/$padrao]
    if {[llength $achados] == 0} {
        puts "ERRO: nenhum arquivo '$padrao' em $dir"
        puts "Liste com: ls -R $dir"
        return -code error
    }
    set arquivo [lindex [lsort $achados] 0]
    puts "TLU+: $arquivo"
    return $arquivo
}

set TLUP_MAX [procura_arquivo $STARRC_DIR *Cmax*.tluplus]
set TLUP_MIN [procura_arquivo $STARRC_DIR *Cmin*.tluplus]
set TLUP_MAP [procura_arquivo $STARRC_DIR *tluplus*.map]

read_parasitic_tech \
    -tlup $TLUP_MAX \
    -layermap $TLUP_MAP \
    -name Cmax

read_parasitic_tech \
    -tlup $TLUP_MIN \
    -layermap $TLUP_MAP \
    -name Cmin


# ------------------------------------------------------------
# 2. Cenarios de analise (MCMM)
#
# Antes havia um cenario unico no corner tipico, e o corner
# rapido era aproximado aumentando a incerteza de hold para
# 0,25 ns no CTS e no roteamento. A auditoria de STA mostrou
# que isso nao reproduz o corner ff (docs/auditoria_sta.md).
# Agora o proprio otimizador ve os corners e modos de signoff:
#
#   cenario   modo  corner  analise
#   func_tt   func  tt      setup, hold, DRV, potencia
#   func_ff   func  ff      hold
#   scan_tt   scan  tt      hold
#   scan_ff   scan  ff      hold
#
# Modo func: scan_en = 0 (operacao normal).
# Modo scan: sem case analysis. Inclui o deslocamento da cadeia
# (Q -> SI), as transicoes de scan_en (-> SE) e scan_in.
# Incerteza de hold: 0,10 ns do SDC em todos os cenarios.
#
# Corners da biblioteca SAED32 (selecionados por PVT na NDM):
#   tt  tt0p85v25c   0,85 V   25 C   parasitas Cmin/Cmax
#   ff  ff0p95vn40c  0,95 V  -40 C   parasitas Cmin
# ------------------------------------------------------------

set CENARIOS {
    func_tt func tt
    func_ff func ff
    scan_tt scan tt
    scan_ff scan ff
}

foreach modo {func scan} { create_mode $modo }
create_corner tt
create_corner ff
foreach {cen modo corner} $CENARIOS {
    create_scenario -name $cen -mode $modo -corner $corner
}
current_scenario func_tt

# Remove o cenario padrao criado em setup.tcl
foreach cmd {remove_scenarios remove_modes remove_corners} {
    catch {$cmd default}
}

# PVT e parasitas de cada corner
set_process_number 1.0 -corners tt
set_temperature    25  -corners tt
set_voltage 0.85 -corners tt -object_list [get_supply_nets VDD]
set_voltage 0.0  -corners tt -object_list [get_supply_nets VSS]
set_parasitic_parameters -corners tt -early_spec Cmin -late_spec Cmax

# nom_process da biblioteca ff0p95vn40c e 1.01 (tt: 1.00). Com
# 1.0 no corner ff, o FC preferiu o pane de mesmo processo e
# temperatura com 0,85 V (tt0p85vn40c), aviso PVT-030.
set_process_number 1.01 -corners ff
set_temperature    -40  -corners ff
set_voltage 0.95 -corners ff -object_list [get_supply_nets VDD]
set_voltage 0.0  -corners ff -object_list [get_supply_nets VSS]
set_parasitic_parameters -corners ff -early_spec Cmin -late_spec Cmin

# Confere o pane da NDM escolhido para cada corner. A otimizacao
# de hold no corner errado custaria horas de execucao.
# O report_pvt so detalha os corners com diferenca de PVT
# (PVT-020/PVT-030, valores especificados x efetivos); um corner
# exato e informado com "Corner <nome>: no PVT mismatches"
# (PVT-032). O nome do corner da biblioteca nao e mostrado.
redirect -variable txt {report_pvt}
set f [open pnr/reports/place/pvt.rpt w]
puts $f $txt
close $f
set falhou 0
foreach corner {tt ff} {
    if {[string match "*Corner ${corner}: no PVT mismatches*" $txt]} {
        puts "PVT conferido: corner $corner sem diferencas (PVT-032)"
    } else {
        puts "ERRO: corner $corner com PVT diferente da biblioteca."
        set falhou 1
    }
}
if {$falhou} {
    puts "Veja pnr/reports/place/pvt.rpt"
    return -code error
}


# ------------------------------------------------------------
# 3. Restricoes de cada cenario
# ------------------------------------------------------------

foreach {cen modo corner} $CENARIOS {
    current_scenario $cen
    read_sdc pnr/constraints/filtro_pdm_physical.sdc
    read_sdc pnr/constraints/filtro_pdm_dft.sdc
    if {$modo eq "func"} {
        set_case_analysis 0 [get_ports scan_en]
    }
}

set_scenario_status func_tt \
    -setup true -hold true \
    -max_transition true -max_capacitance true \
    -leakage_power true -dynamic_power true

foreach cen {func_ff scan_tt scan_ff} {
    set_scenario_status $cen \
        -setup false -hold true \
        -max_transition false -max_capacitance false \
        -leakage_power false -dynamic_power false
}

current_scenario func_tt


# ------------------------------------------------------------
# 4. Conferencia
# ------------------------------------------------------------

report_scenarios > pnr/reports/place/scenarios.rpt
report_scenarios
report_clocks
report_parasitic_parameters
