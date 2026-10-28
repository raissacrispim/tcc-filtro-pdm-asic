# ============================================================
# dv_abre.tcl
# Netlist da sintese no Design Vision (versao v1.0-tcc)
#
# Uso (terminal dentro da sessao X2Go, fora do projeto):
#
#   mkdir -p ~/tcc_imagens_dv && cd ~/tcc_imagens_dv
#   design_vision -f ~/tcc_filtro/imagens/scripts/dv_abre.tcl
#
# Le synth/netlist/filtro_pdm_syn.ddc (gerado na mesma sintese
# que filtro_pdm_syn.v, registrado em docs/congelamento_v1.0.md)
# com as bibliotecas de synth/scripts/synth.tcl. Nada e escrito
# no projeto: os logs ficam no diretorio de execucao.
# ============================================================

set PROJ [file normalize ~/tcc_filtro]
if {[info exists ::env(TCC_PROJ)]} { set PROJ [file normalize $::env(TCC_PROJ)] }

set LIB_PATH /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm
set TARGET_LIB saed32rvt_tt0p85v25c.db
set_app_var search_path [concat $search_path $LIB_PATH]
set_app_var target_library $TARGET_LIB
set_app_var link_library "* $TARGET_LIB"

read_ddc $PROJ/synth/netlist/filtro_pdm_syn.ddc
current_design filtro_pdm
link

puts ""
puts "============================================"
puts "Design Vision: filtro_pdm (v1.0-tcc, netlist da sintese)"
puts "Celulas no topo e no FIR:"
report_hierarchy -noleaf
puts "============================================"

catch {gui_start}
