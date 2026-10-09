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
# Constraints de timing
# ============================================================

# Restricoes completas: clock de 4,8 MHz, incerteza,
# atrasos de entrada/saida e cargas.
# O mesmo arquivo e lido no Fusion Compiler (setup.tcl).
read_sdc pnr/constraints/filtro_pdm_physical.sdc

# Exibe os clocks definidos para conferencia
report_clocks

puts "============================================"
puts "RTL analisado, elaborado e linkado"
puts "Top: filtro_pdm"
puts "============================================"

# ============================================================
# Sintese e otimizacao
# ============================================================

# Sintese logica e mapeamento para a biblioteca tecnologica
compile_ultra

puts "============================================"
puts "Sintese e mapeamento concluidos"
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

puts "============================================"
puts "Relatorios gerados em synth/reports"
puts "============================================"

# ============================================================
# Resultados da sintese
# ============================================================

# Banco de dados do Design Compiler
write -format ddc -hierarchy \
    -output synth/netlist/filtro_pdm_syn.ddc

# Netlist Verilog mapeado para standard cells
write -format verilog -hierarchy \
    -output synth/netlist/filtro_pdm_syn.v

# Constraints utilizadas na sintese
write_sdc synth/netlist/filtro_pdm_syn.sdc

puts "============================================"
puts "Fluxo de sintese concluido"
puts "Netlist: synth/netlist/filtro_pdm_syn.v"
puts "DDC:     synth/netlist/filtro_pdm_syn.ddc"
puts "SDC:     synth/netlist/filtro_pdm_syn.sdc"
puts "============================================"
