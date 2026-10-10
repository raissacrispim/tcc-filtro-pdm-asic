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
# Valores de referencia do floorplan original, obtido com
# -core_utilization 0.60 e -side_ratio {1 1}. O Fusion
# Compiler ajusta as dimensoes para um numero inteiro de
# sites e linhas de celulas (core resultante: 220.40 x 217.36).

initialize_floorplan \
    -control_type core \
    -shape R \
    -side_length {220.55 219.03} \
    -core_offset {10}

report_utilization


# ------------------------------------------------------------
# 3. Salva checkpoint do floorplan
# ------------------------------------------------------------

save_block -label floorplan
