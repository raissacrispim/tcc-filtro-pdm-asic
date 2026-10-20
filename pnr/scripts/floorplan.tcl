# ============================================================
# floorplan.tcl
# Floorplan inicial
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# ============================================================

# ------------------------------------------------------------
# 1. Abre a design library e o checkpoint inicial
# ------------------------------------------------------------

open_lib pnr/work/filtro_pdm.dlib
open_block filtro_pdm/init


# ------------------------------------------------------------
# 2. Cria o floorplan
# ------------------------------------------------------------

# Dimensoes do core (largura x altura, em um), fixas para que
# o tamanho nao varie entre execucoes.
#
# O floorplan original (220,40 x 217,36 um, obtido com
# -core_utilization 0.60) chegou a 84% de utilizacao depois do
# CIC de 18 bits e do DFT. Com MCMM (hold no corner ff) faltou
# espaco para os buffers: o placement deixou somadores do FIR a
# mais de 100 um dos flip-flops que os alimentam, e nem o
# route_opt nem o ECO de capacitancia maxima conseguiam colocar
# buffers perto do driver (docs/auditoria_sta.md). O core passou
# para 240 x 240 um (~70% de utilizacao). O Fusion Compiler
# ajusta as dimensoes para um numero inteiro de sites e linhas.
# O die cresce junto: core_offset de 10 um em cada lado.

initialize_floorplan \
    -control_type core \
    -shape R \
    -side_length {240.0 240.0} \
    -core_offset {10}

report_utilization


# ------------------------------------------------------------
# 3. Salva checkpoint do floorplan
# ------------------------------------------------------------

save_block -label floorplan
