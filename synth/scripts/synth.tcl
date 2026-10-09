# ============================================================
# Sintese logica - Filtro PDM CIC + FIR
# Tecnologia: SAED32
# Ferramenta: Synopsys Design Compiler
# ============================================================

# Diretorio da biblioteca de standard cells
set LIB_PATH /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm

# Biblioteca utilizada nesta primeira sintese
set TARGET_LIB saed32rvt_tt0p85v25c.db

# Informa ao Design Compiler onde procurar bibliotecas
set_app_var search_path [concat $search_path $LIB_PATH]

# Biblioteca para mapeamento tecnologico
set_app_var target_library $TARGET_LIB

# Bibliotecas disponiveis para resolver as referencias do projeto
set_app_var link_library "* $TARGET_LIB"

puts "============================================"
puts "Configuracao inicial da sintese"
puts "Biblioteca: $TARGET_LIB"
puts "============================================"

# ============================================================
# Leitura do RTL
# ============================================================

analyze -format sverilog {
    rtl/integrador.sv
    rtl/cic_integradores.sv
    rtl/decimador.sv
    rtl/comb.sv
    rtl/cic_combs.sv
    rtl/cic.sv
    rtl/fir.sv
    rtl/filtro_pdm.sv
}

# Constroi a hierarquia a partir do modulo de topo
elaborate filtro_pdm

# Define explicitamente o design corrente
current_design filtro_pdm

# Resolve as referencias entre os modulos e bibliotecas
link

# Verifica a consistencia estrutural do design
check_design

# ============================================================
# Portas de teste (DFT)
#
# Criadas aqui, e nao no RTL, para manter o RTL funcional
# inalterado. Sao conectadas a cadeia de scan pelo insert_dft.
# ============================================================

create_port -direction in  scan_en
create_port -direction in  scan_in
create_port -direction out scan_out

# ============================================================
# Constraints de timing
# ============================================================

# Restricoes completas: clock de 4,8 MHz, incerteza,
# atrasos de entrada/saida e cargas.
# O mesmo arquivo e lido no Fusion Compiler (setup.tcl).
read_sdc pnr/constraints/filtro_pdm_physical.sdc

# Restricoes das portas de scan
read_sdc pnr/constraints/filtro_pdm_dft.sdc

# Exibe os clocks definidos para conferencia
report_clocks

puts "============================================"
puts "RTL analisado, elaborado e linkado"
puts "Top: filtro_pdm"
puts "============================================"

# ============================================================
# Sintese e otimizacao
# ============================================================

# Evita comandos assign na netlist (portas ligadas entre si
# ou a constantes), que atrapalham o P&R e o LVS
set_fix_multiple_port_nets -all -buffer_constants

# ------------------------------------------------------------
# Configuracao do DFT
#
# Estilo: flip-flop com multiplexador (mux-scan)
# Uma unica cadeia de scan com todos os flip-flops.
# O reset e sincrono (logica no caminho de dados), portanto
# nao precisa ser declarado como sinal de teste.
# ------------------------------------------------------------

set_scan_configuration \
    -style multiplexed_flip_flop \
    -chain_count 1

set_dft_signal -view existing_dft \
    -type ScanClock \
    -port clk \
    -timing {45 55}

set_dft_signal -view spec \
    -type ScanEnable \
    -port scan_en \
    -active_state 1

set_dft_signal -view spec \
    -type ScanDataIn \
    -port scan_in

set_dft_signal -view spec \
    -type ScanDataOut \
    -port scan_out

# Sintese logica e mapeamento para a biblioteca tecnologica,
# ja utilizando flip-flops com scan
compile_ultra -scan

puts "============================================"
puts "Sintese e mapeamento concluidos"
puts "============================================"

# ------------------------------------------------------------
# Insercao da cadeia de scan
# ------------------------------------------------------------

create_test_protocol

dft_drc -verbose > synth/reports/dft_drc_pre.rpt

preview_dft > synth/reports/dft_preview.rpt

insert_dft

dft_drc -coverage_estimate > synth/reports/dft_drc_post.rpt

# Otimizacao incremental apos a insercao do scan
compile_ultra -incremental -scan

puts "============================================"
puts "Cadeia de scan inserida"
puts "============================================"

# ============================================================
# Relatorios
# ============================================================

check_timing > synth/reports/check_timing.rpt
report_qor > synth/reports/qor.rpt
report_area -hierarchy > synth/reports/area_hier.rpt
report_timing -delay_type max -max_paths 10 > synth/reports/timing_max.rpt
report_timing -delay_type min -max_paths 10 > synth/reports/timing_min.rpt
report_reference > synth/reports/reference.rpt
report_resources > synth/reports/resources.rpt
report_scan_path -view existing_dft -chain all > synth/reports/scan_path.rpt
report_dft_signal -view existing_dft > synth/reports/dft_signals.rpt

puts "============================================"
puts "Relatorios gerados em synth/reports"
puts "============================================"

# ============================================================
# Resultados da sintese
# ============================================================

# Nomes compativeis com Verilog para P&R, ATPG e simulacao
change_names -rules verilog -hierarchy

# Banco de dados do Design Compiler
write -format ddc -hierarchy \
    -output synth/netlist/filtro_pdm_syn.ddc

# Netlist Verilog mapeado para standard cells
write -format verilog -hierarchy \
    -output synth/netlist/filtro_pdm_syn.v

# Constraints utilizadas na sintese
write_sdc synth/netlist/filtro_pdm_syn.sdc

# Atrasos estimados para simulacao gate-level (opcional)
write_sdf synth/netlist/filtro_pdm_syn.sdf

# Ordem da cadeia de scan para o placement (Fusion Compiler)
write_scan_def -output synth/netlist/filtro_pdm_syn.scandef

# Protocolo de teste para o ATPG (TestMAX ATPG)
write_test_protocol -output synth/netlist/filtro_pdm_syn.spf

puts "============================================"
puts "Fluxo de sintese concluido"
puts "Netlist: synth/netlist/filtro_pdm_syn.v"
puts "DDC:     synth/netlist/filtro_pdm_syn.ddc"
puts "SDC:     synth/netlist/filtro_pdm_syn.sdc"
puts "============================================"
