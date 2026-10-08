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

initialize_floorplan \
    -control_type core \
    -shape R \
    -side_ratio {1 1} \
    -core_utilization 0.60 \
    -core_offset {10}


# ------------------------------------------------------------
# 3. Salva checkpoint do floorplan
# ------------------------------------------------------------

save_block -label floorplan
