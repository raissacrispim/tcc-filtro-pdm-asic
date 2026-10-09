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

# Dimensoes fixas do core (largura x altura, em um).
#
# Correspondem ao floorplan original, obtido com
# -core_utilization 0.60 e -side_ratio {1 1}.
# Fixar as dimensoes mantem validas as coordenadas dos
# terminais VDD_TOP/VSS_TOP usadas em power_plan.tcl
# (topo do core 229.03 + offset do anel 2.0).

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
