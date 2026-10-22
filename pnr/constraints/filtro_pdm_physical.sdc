# ============================================================
# FILTRO PDM - RESTRICOES DE IMPLEMENTACAO FISICA
# Tecnologia: SAED32
#
# Clock: 4,8 MHz
# Microfone: Knowles SPH0641LU4H-1
# Premissa: SELECT = GND
#
# Origem de cada valor (docs/auditoria_final.md, P6):
#
#   REQUISITO  clock de 4,8 MHz (periodo 208,333 ns): taxa PDM
#              do microfone; a saida de 300 kHz (R = 16) e
#              gerada no mesmo dominio, sem outro clock.
#   DATASHEET  pdm_in: dado valido 18-40 ns apos a borda de
#              descida (SPH0641LU4H-1, SELECT = GND), sem o
#              atraso de placa.
#   HIPOTESE   valores preliminares de integracao, sem fonte
#              externa; nao equivalem a um receptor real:
#              - incerteza de clock: setup 1,0 ns, hold 0,10 ns
#                (jitter da fonte + margem de projeto);
#              - rst, scan_en, scan_in: atraso de entrada
#                0 ns (min, pior caso de hold) a 20 ns (max);
#              - saidas e scan_out: atraso 0 ns (min) a 20 ns
#                (max), carga de 2 fF (bloco integrado, nao pad);
#              - entradas dirigidas por NBUFFX8_RVT;
#              - vclk: circuitos externos recebem o clock da
#                placa como a porta clk, sem skew de placa;
#              - clock de shift do scan igual ao funcional.
#
# Estes valores nao foram ajustados para melhorar a STA.
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

# Clock virtual dos circuitos externos (microfone, receptor,
# testador). Representa o clock da placa na porta clk: ideal,
# sem latencia. As restricoes de E/S sao referenciadas a ele,
# e nao a arvore de clock interna do chip.
#
# Motivo (docs/auditoria_sta.md): com as E/S referenciadas a
# clk, o Fusion Compiler gravava no SDC uma latencia de E/S
# estimada no corner tipico (0,235/0,265 ns), maior que a
# latencia real dos registradores no corner rapido (0,05-0,08
# ns), o que criava violacoes de hold nas saidas sem base fisica
# e escondia as violacoes reais nas entradas.
create_clock -name vclk \
    -period 208.333 \
    -waveform {0 104.166}

# HIPOTESE: margens de setup e hold (jitter da fonte de clock
# e margem de projeto). Mantidas iguais em todo o fluxo e no
# signoff; revisar com a caracterizacao da fonte de clock.
set_clock_uncertainty -setup 1.0 [get_clocks clk]
set_clock_uncertainty -hold 0.10 [get_clocks clk]

# Mesmas margens nos caminhos de E/S (entre vclk e clk)
set_clock_uncertainty -setup 1.0 \
    -from [get_clocks vclk] -to [get_clocks clk]
set_clock_uncertainty -hold 0.10 \
    -from [get_clocks vclk] -to [get_clocks clk]
set_clock_uncertainty -setup 1.0 \
    -from [get_clocks clk] -to [get_clocks vclk]
set_clock_uncertainty -hold 0.10 \
    -from [get_clocks clk] -to [get_clocks vclk]

# Transicao do clock ideal (antes do CTS).
# Apos o CTS, o clock propagado substitui este valor.
set_clock_transition 0.10 [get_clocks clk]

# Celula que dirige as entradas de dados (fonte externa
# preliminar). Define a transicao de entrada conforme a carga
# de cada porta.
set_driving_cell -lib_cell NBUFFX8_RVT -pin Y \
    [get_ports {pdm_in rst}]

# Transicao maxima permitida em todas as redes.
# A biblioteca SAED32 nao define um valor padrao
# (aviso OPT-070 no Fusion Compiler).
set_max_transition 0.50 [current_design]

# ------------------------------------------------------------
# ENTRADA PDM
# ------------------------------------------------------------

# DATA disponibilizado apos a borda de descida do clock.
# Atrasos do microfone: minimo 18 ns, maximo 40 ns.
# Ainda nao inclui atrasos externos de interconexao.

set_input_delay -clock vclk -clock_fall \
    -min 18.0 [get_ports pdm_in]

set_input_delay -clock vclk -clock_fall \
    -max 40.0 [get_ports pdm_in]

# ------------------------------------------------------------
# RESET SINCRONO
# ------------------------------------------------------------

# Hipotese: reset gerado por logica sincrona ao clock.
# Revisar se a fonte real do reset for assincrona.

set_input_delay -clock vclk \
    -min 0.0 [get_ports rst]

set_input_delay -clock vclk \
    -max 20.0 [get_ports rst]

# ------------------------------------------------------------
# SAIDAS DIGITAIS
# ------------------------------------------------------------

# Hipotese: receptor sincrono ao mesmo clock.
# Orçamento externo preliminar de 20 ns.

set_output_delay -clock vclk \
    -min 0.0 [get_ports {y_out[*] valid_out}]

set_output_delay -clock vclk \
    -max 20.0 [get_ports {y_out[*] valid_out}]

# Carga externa preliminar de 2 fF por saida.
# Nao representa um pad de I/O convencional.

set_load 2.0 [get_ports {y_out[*] valid_out}]

# ------------------------------------------------------------
# PENDENCIAS DE INTEGRACAO
# ------------------------------------------------------------

# - Modelar atraso de placa e diferenca de chegada do clock
#   (hoje: clock externo = clock na porta, atrasos minimos 0).
# - Confirmar fonte e temporizacao do reset.
# - Definir celulas de I/O e carga real do receptor.
# - Revisar incerteza para os cenarios de signoff.
