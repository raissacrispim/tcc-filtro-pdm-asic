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
# CONFERIR NO SERVIDOR antes de executar:
#
#   ls /Tools/PDK/SAED32/EDK_Digital/tech/
#   ls /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/ndm/
#
# 1. A biblioteca de referencia usada em setup.tcl
#    (saed32rvt_frame_only.ndm) contem apenas a visao fisica.
#    Para otimizacao guiada por timing, o bloco precisa de uma
#    NDM com visao de timing (ex.: *_frame_timing*.ndm ou
#    *_c.ndm). Se existir, troque PHYSICAL_LIB em setup.tcl
#    e recrie a design library.
#
#    Teste rapido apos abrir o bloco:
#        report_lib -timing [get_libs]
#    ou
#        get_lib_cells */DFFX1_RVT/timing
#
# 2. Os nomes dos arquivos TLU+ abaixo seguem o padrao do
#    SAED32 EDK. Ajuste os caminhos se forem diferentes.
# ============================================================

# ------------------------------------------------------------
# 1. Arquivos de extracao de parasitas (TLU+)
# ------------------------------------------------------------

set TLUP_DIR /Tools/PDK/SAED32/EDK_Digital/tech/star_rcxt

set TLUP_MAX $TLUP_DIR/saed32nm_1p9m_Cmax.tluplus
set TLUP_MIN $TLUP_DIR/saed32nm_1p9m_Cmin.tluplus
set TLUP_MAP $TLUP_DIR/saed32nm_tf_itf_tluplus.map

foreach arquivo [list $TLUP_MAX $TLUP_MIN $TLUP_MAP] {
    if {![file exists $arquivo]} {
        puts "ERRO: arquivo nao encontrado: $arquivo"
        puts "Ajuste TLUP_DIR em pnr/scripts/timing_setup.tcl"
        return -code error
    }
}

read_parasitic_tech \
    -tlup $TLUP_MAX \
    -layermap $TLUP_MAP \
    -name Cmax

read_parasitic_tech \
    -tlup $TLUP_MIN \
    -layermap $TLUP_MAP \
    -name Cmin


# ------------------------------------------------------------
# 2. Cenario de analise
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
# 3. Restricoes de timing
#
# Ja lidas em setup.tcl. Conferencia:
# ------------------------------------------------------------

report_scenarios
report_clocks
report_parasitic_parameters
