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
# ATENCAO:
# Versao candidata, ainda nao validada no Fusion Compiler.
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
# 2. Condicoes de operacao (PVT)
#
# A NDM contem varios corners. Seleciona o tipico
# tt0p85v25c, o mesmo usado na sintese.
# ------------------------------------------------------------

set_process_number 1.0
set_voltage 0.85 -object_list [get_supply_nets VDD]
set_voltage 0.0  -object_list [get_supply_nets VSS]
set_temperature 25

report_pvt


# ------------------------------------------------------------
# 3. Cenario de analise
#
# Cenario unico no corner tipico (tt0p85v25c), o mesmo da
# sintese. Setup analisado com Cmax e hold com Cmin.
#
# Evolucao futura: cenarios adicionais nos corners ss (setup)
# e ff (hold).
# ------------------------------------------------------------

set_parasitic_parameters \
    -early_spec Cmin \
    -late_spec Cmax

set_scenario_status [current_scenario] \
    -setup true \
    -hold true \
    -max_transition true \
    -max_capacitance true \
    -leakage_power true \
    -dynamic_power true


# ------------------------------------------------------------
# 4. Restricoes de timing
#
# Ja lidas em setup.tcl. Conferencia:
# ------------------------------------------------------------

report_scenarios
report_clocks
report_parasitic_parameters
