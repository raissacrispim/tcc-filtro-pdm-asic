# ============================================================
# FILTRO PDM - RESTRICOES DE IMPLEMENTACAO FISICA
# Tecnologia: SAED32
#
# Clock: 4,8 MHz
# Microfone: Knowles SPH0641LU4H-1
# Premissa: SELECT = GND
#
# As restricoes de reset, saida, carga e incerteza
# representam um cenario preliminar de integracao.
# Nao equivalem a especificacoes de um receptor real.
# ============================================================

set_units -time ns -resistance MOhm -capacitance fF \
          -voltage V -current uA

# ------------------------------------------------------------
# CLOCK
# ------------------------------------------------------------

create_clock -name clk \
    -period 208.333 \
    -waveform {0 104.166} \
    [get_ports clk]

# Margem preliminar de temporizacao.
# Margens preliminares para setup e hold.
# Revisar apos CTS e caracterizacao da fonte de clock.
set_clock_uncertainty -setup 1.0 [get_clocks clk]
set_clock_uncertainty -hold 0.10 [get_clocks clk]

# Transicao do clock ideal (antes do CTS).
# Apos o CTS, o clock propagado substitui este valor.
set_clock_transition 0.10 [get_clocks clk]

# Transicao preliminar das entradas de dados.
set_input_transition 0.10 [get_ports {pdm_in rst}]

# ------------------------------------------------------------
# ENTRADA PDM
# ------------------------------------------------------------

# DATA disponibilizado apos a borda de descida do clock.
# Atrasos do microfone: minimo 18 ns, maximo 40 ns.
# Ainda nao inclui atrasos externos de interconexao.

set_input_delay -clock clk -clock_fall \
    -min 18.0 [get_ports pdm_in]

set_input_delay -clock clk -clock_fall \
    -max 40.0 [get_ports pdm_in]

# ------------------------------------------------------------
# RESET SINCRONO
# ------------------------------------------------------------

# Hipotese: reset gerado por logica sincrona ao clock.
# Revisar se a fonte real do reset for assincrona.

set_input_delay -clock clk \
    -min 0.0 [get_ports rst]

set_input_delay -clock clk \
    -max 20.0 [get_ports rst]

# ------------------------------------------------------------
# SAIDAS DIGITAIS
# ------------------------------------------------------------

# Hipotese: receptor sincrono ao mesmo clock.
# Orçamento externo preliminar de 20 ns.

set_output_delay -clock clk \
    -min 0.0 [get_ports {y_out[*] valid_out}]

set_output_delay -clock clk \
    -max 20.0 [get_ports {y_out[*] valid_out}]

# Carga externa preliminar de 2 fF por saida.
# Nao representa um pad de I/O convencional.

set_load 2.0 [get_ports {y_out[*] valid_out}]

# ------------------------------------------------------------
# PENDENCIAS DE INTEGRACAO
# ------------------------------------------------------------

# - Modelar atraso de placa e diferenca de chegada do clock.
# - Confirmar fonte e temporizacao do reset.
# - Definir celulas de I/O e carga real do receptor.
# - Revisar incerteza para os cenarios de signoff.
