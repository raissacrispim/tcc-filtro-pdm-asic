# ============================================================
# setup.tcl
# Preparacao do ambiente de implementacao fisica
# Projeto: Filtro PDM CIC + FIR
# Ferramenta: Synopsys Fusion Compiler
# Tecnologia: SAED32 1P9M - RVT
# ============================================================

# ------------------------------------------------------------
# 1. Caminhos do PDK
# ------------------------------------------------------------

set TECH_FILE /Tools/PDK/SAED32/EDK_Digital/tech/tf/saed32nm_1p9m.tf

set LOGIC_LIB /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/db_nldm/saed32rvt_tt0p85v25c.db

set PHYSICAL_LIB /Tools/PDK/SAED32/EDK_Digital/lib/stdcell_rvt/ndm/saed32rvt_frame_only.ndm


# ------------------------------------------------------------
# 2. Biblioteca logica
# ------------------------------------------------------------

set_app_var link_library "* $LOGIC_LIB"


# ------------------------------------------------------------
# 3. Criacao da design library
# ------------------------------------------------------------

create_lib \
    -technology $TECH_FILE \
    -ref_libs $PHYSICAL_LIB \
    pnr/work/filtro_pdm.dlib


# ------------------------------------------------------------
# 4. Leitura da netlist sintetizada
# ------------------------------------------------------------

read_verilog \
    -design filtro_pdm \
    -top filtro_pdm \
    synth/netlist/filtro_pdm_syn.v


# ------------------------------------------------------------
# 5. Verificacao do bloco corrente
# ------------------------------------------------------------

current_block
list_blocks


# ------------------------------------------------------------
# 6. Leitura das restricoes da sintese
# ------------------------------------------------------------

read_sdc synth/netlist/filtro_pdm_syn.sdc


# ------------------------------------------------------------
# 7. Verificacoes iniciais
# ------------------------------------------------------------

report_ref_libs

report_clocks

check_design \
    -checks {dp_pre_floorplan netlist unbound} \
    -log_file pnr/reports/check_pre_floorplan.log

# ------------------------------------------------------------
# 8. Salva checkpoint inicial
# ------------------------------------------------------------

save_block -label init
