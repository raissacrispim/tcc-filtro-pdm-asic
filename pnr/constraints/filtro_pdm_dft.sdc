# ============================================================
# FILTRO PDM - RESTRICOES DAS PORTAS DE TESTE (DFT)
# Tecnologia: SAED32
#
# Portas criadas na sintese (synth.tcl) para a cadeia de scan:
#   scan_en  - habilita o deslocamento (shift) da cadeia
#   scan_in  - entrada serial da cadeia
#   scan_out - saida serial da cadeia
#
# Lido depois de filtro_pdm_physical.sdc, na sintese e no
# Fusion Compiler. Em operacao normal, scan_en = 0.
#
# Mesmas hipoteses preliminares das demais entradas/saidas:
# testador sincrono ao clock, orcamento externo de 20 ns.
# ============================================================

set_input_delay -clock clk \
    -min 0.0 [get_ports {scan_en scan_in}]

set_input_delay -clock clk \
    -max 20.0 [get_ports {scan_en scan_in}]

set_input_transition 0.10 [get_ports {scan_en scan_in}]

set_output_delay -clock clk \
    -min 0.0 [get_ports scan_out]

set_output_delay -clock clk \
    -max 20.0 [get_ports scan_out]

set_load 2.0 [get_ports scan_out]
