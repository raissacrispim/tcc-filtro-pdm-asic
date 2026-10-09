# ============================================================
# FILTRO PDM - RESTRICOES PARA IMPLEMENTACAO FISICA
# Tecnologia: SAED32
# Unidade de tempo: ns
#
# Premissa:
# Microfone Knowles SPH0641LU4H-1 com SELECT = GND.
#
# IMPORTANTE:
# Este arquivo contem apenas restricoes fundamentadas
# no RTL e na temporizacao do microfone.
# As restricoes da interface de saida ainda serao definidas.
# ============================================================

set_units -time ns -capacitance fF

# Clock principal: 4,8 MHz
create_clock -name clk \
    -period 208.333 \
    -waveform {0 104.166} \
    [get_ports clk]

# Entrada PDM:
# DATA disponibilizado apos a borda de descida do clock.
# Valores minimo e maximo do datasheet.
#
# Hipotese inicial: atrasos adicionais externos nulos.
# Revisar ao definir a integracao fisica do microfone.
set_input_delay -clock clk -clock_fall \
    -min 18.0 [get_ports pdm_in]

set_input_delay -clock clk -clock_fall \
    -max 40.0 [get_ports pdm_in]

# PENDENTE:
# - Atrasos de entrada do reset sincrono.
# - Incerteza de clock.
# - Atrasos de saida.
# - Cargas eletricas das saidas.
# - Atrasos externos de placa/interconexao.
