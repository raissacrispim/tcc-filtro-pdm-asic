################################################################################
#
# Design name:  filtro_pdm
#
# Created by fc write_sdc on Thu Oct 22 11:44:52 2026
#
################################################################################

set sdc_version 2.2
set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA

################################################################################
#
# Units
# time_unit               : 1e-09
# resistance_unit         : 1000000
# capacitive_load_unit    : 1e-15
# voltage_unit            : 1
# current_unit            : 1e-06
# power_unit              : 1e-12
################################################################################


# Mode: func
# Corner: tt
# Scenario: func_tt

# /home/raissa.crispim/tcc_filtro/pnr/scripts/timing_setup.tcl, line 149
set_case_analysis 0 [get_ports {scan_en}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   43
create_clock -name clk -period 208.333 -waveform {0 104.166} [get_ports {clk}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   58; /home/raissa.crispim/tcc_filtro/pnr/scripts/vclk_ideal.tcl, line 40; \
#   /home/raissa.crispim/tcc_filtro/pnr/scripts/cts.tcl, line 114; \
#   /home/raissa.crispim/tcc_filtro/pnr/scripts/route.tcl, line 105; \
#   /home/raissa.crispim/tcc_filtro/pnr/scripts/route.tcl, line 110; \
#   /home/raissa.crispim/tcc_filtro/pnr/scripts/finish.tcl, line 401
create_clock -name vclk -period 208.333 -waveform {0 104.166}
set_propagated_clock [get_clocks {clk}]
set_load -pin_load 2 [get_ports {y_out[18]}]
set_load -pin_load 2 [get_ports {y_out[17]}]
set_load -pin_load 2 [get_ports {y_out[16]}]
set_load -pin_load 2 [get_ports {y_out[15]}]
set_load -pin_load 2 [get_ports {y_out[14]}]
set_load -pin_load 2 [get_ports {y_out[13]}]
set_load -pin_load 2 [get_ports {y_out[12]}]
set_load -pin_load 2 [get_ports {y_out[11]}]
set_load -pin_load 2 [get_ports {y_out[10]}]
set_load -pin_load 2 [get_ports {y_out[9]}]
set_load -pin_load 2 [get_ports {y_out[8]}]
set_load -pin_load 2 [get_ports {y_out[7]}]
set_load -pin_load 2 [get_ports {y_out[6]}]
set_load -pin_load 2 [get_ports {y_out[5]}]
set_load -pin_load 2 [get_ports {y_out[4]}]
set_load -pin_load 2 [get_ports {y_out[3]}]
set_load -pin_load 2 [get_ports {y_out[2]}]
set_load -pin_load 2 [get_ports {y_out[1]}]
set_load -pin_load 2 [get_ports {y_out[0]}]
set_load -pin_load 2 [get_ports {valid_out}]
set_load -pin_load 2 [get_ports {scan_out}]
# /home/raissa.crispim/tcc_filtro/pnr/scripts/timing_setup.tcl, line 100
set_voltage 0.85 -object_list {VDD}
# /home/raissa.crispim/tcc_filtro/pnr/scripts/timing_setup.tcl, line 101
set_voltage 0 -object_list {VSS}
# Warning: Libcell power domain derates are skipped!

# Set latency for io paths.
set_clock_uncertainty -setup 1 [get_clocks {clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {clk}]
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks \
    {vclk}] -setup 1
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks \
    {vclk}] -hold 0.1
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks \
    {vclk}] -setup 1
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks \
    {vclk}] -hold 0.1
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks \
    {vclk}] -setup 1
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks \
    {vclk}] -hold 0.1
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks \
    {vclk}] -setup 1
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks \
    {vclk}] -hold 0.1
set_clock_uncertainty -rise_from [get_clocks {vclk}] -rise_to [get_clocks \
    {clk}] -setup 1
set_clock_uncertainty -rise_from [get_clocks {vclk}] -rise_to [get_clocks \
    {clk}] -hold 0.1
set_clock_uncertainty -rise_from [get_clocks {vclk}] -fall_to [get_clocks \
    {clk}] -setup 1
set_clock_uncertainty -rise_from [get_clocks {vclk}] -fall_to [get_clocks \
    {clk}] -hold 0.1
set_clock_uncertainty -fall_from [get_clocks {vclk}] -rise_to [get_clocks \
    {clk}] -setup 1
set_clock_uncertainty -fall_from [get_clocks {vclk}] -rise_to [get_clocks \
    {clk}] -hold 0.1
set_clock_uncertainty -fall_from [get_clocks {vclk}] -fall_to [get_clocks \
    {clk}] -setup 1
set_clock_uncertainty -fall_from [get_clocks {vclk}] -fall_to [get_clocks \
    {clk}] -hold 0.1
set_clock_transition 0.1 [get_clocks {clk}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   84
set_driving_cell -lib_cell NBUFFX8_RVT -pin Y [get_ports {rst}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   84
set_driving_cell -lib_cell NBUFFX8_RVT -pin Y [get_ports {pdm_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 25
set_driving_cell -lib_cell NBUFFX8_RVT -pin Y [get_ports {scan_en}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 25
set_driving_cell -lib_cell NBUFFX8_RVT -pin Y [get_ports {scan_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   113; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 116
set_input_delay -clock [get_clocks {vclk}] -min 0 [get_ports {rst}]
set_input_delay -clock [get_clocks {vclk}] -max 20 [get_ports {rst}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   100; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 103
set_input_delay -clock [get_clocks {vclk}] -clock_fall -min 18 [get_ports \
    {pdm_in}]
set_input_delay -clock [get_clocks {vclk}] -clock_fall -max 40 [get_ports \
    {pdm_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[18]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[18]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[17]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[17]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[16]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[16]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[15]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[15]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[14]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[14]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[13]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[13]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[12]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[12]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[11]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[11]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[10]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[10]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[9]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[9]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[8]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[8]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[7]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[7]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[6]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[6]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[5]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[5]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[4]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[4]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[3]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[3]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[2]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[2]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[1]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[1]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {y_out[0]}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {y_out[0]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   126; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 129
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {valid_out}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {valid_out}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 19; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 22
set_input_delay -clock [get_clocks {vclk}] -min 0 [get_ports {scan_en}]
set_input_delay -clock [get_clocks {vclk}] -max 20 [get_ports {scan_en}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 19; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 22
set_input_delay -clock [get_clocks {vclk}] -min 0 [get_ports {scan_in}]
set_input_delay -clock [get_clocks {vclk}] -max 20 [get_ports {scan_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 28; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 31
set_output_delay -clock [get_clocks {vclk}] -min 0 [get_ports {scan_out}]
set_output_delay -clock [get_clocks {vclk}] -max 20 [get_ports {scan_out}]
set_max_transition 0.5 [current_design]
set_max_capacitance 56 [get_clocks {clk}] -clock_path
