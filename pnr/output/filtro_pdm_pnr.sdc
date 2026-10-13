################################################################################
#
# Design name:  filtro_pdm
#
# Created by fc write_sdc on Tue Oct 13 15:03:01 2026
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


# Mode: default
# Corner: default
# Scenario: default

# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   24
create_clock -name clk -period 208.333 -waveform {0 104.166} [get_ports {clk}]
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
# /home/raissa.crispim/tcc_filtro/pnr/scripts/timing_setup.tcl, line 63
set_voltage 0.85 -object_list {VDD}
# /home/raissa.crispim/tcc_filtro/pnr/scripts/timing_setup.tcl, line 64
set_voltage 0 -object_list {VSS}
# Warning: Libcell power domain derates are skipped!

# Set latency for io paths.
# -origin useful_skew
set_clock_latency -min 0.234568 [get_clocks {clk}]
# -origin useful_skew
set_clock_latency -max 0.265257 [get_clocks {clk}]
# Set propagated on clock sources to avoid removing latency for IO paths.
set_propagated_clock  [get_ports {clk}]
set_clock_uncertainty -setup 1 [get_clocks {clk}]
set_clock_uncertainty -hold 0.1 [get_clocks {clk}]
set_clock_transition 0.1 [get_clocks {clk}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   37
set_input_transition 0.1 [get_ports {rst}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   37
set_input_transition 0.1 [get_ports {pdm_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 23
set_input_transition 0.1 [get_ports {scan_en}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 23
set_input_transition 0.1 [get_ports {scan_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   61; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 64
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {rst}]
set_input_delay -clock [get_clocks {clk}] -max 20 [get_ports {rst}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   48; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 51
set_input_delay -clock [get_clocks {clk}] -clock_fall -min 18 [get_ports \
    {pdm_in}]
set_input_delay -clock [get_clocks {clk}] -clock_fall -max 40 [get_ports \
    {pdm_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[18]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[18]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[17]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[17]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[16]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[16]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[15]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[15]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[14]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[14]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[13]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[13]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[12]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[12]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[11]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[11]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[10]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[10]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[9]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[9]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[8]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[8]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[7]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[7]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[6]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[6]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[5]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[5]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[4]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[4]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[3]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[3]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[2]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[2]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[1]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[1]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {y_out[0]}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {y_out[0]}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, line \
#   74; /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_physical.sdc, \
#   line 77
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {valid_out}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {valid_out}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 18; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 21
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {scan_en}]
set_input_delay -clock [get_clocks {clk}] -max 20 [get_ports {scan_en}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 18; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 21
set_input_delay -clock [get_clocks {clk}] -min 0 [get_ports {scan_in}]
set_input_delay -clock [get_clocks {clk}] -max 20 [get_ports {scan_in}]
# /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 26; \
#   /home/raissa.crispim/tcc_filtro/pnr/constraints/filtro_pdm_dft.sdc, line 29
set_output_delay -clock [get_clocks {clk}] -min 0 [get_ports {scan_out}]
set_output_delay -clock [get_clocks {clk}] -max 20 [get_ports {scan_out}]
set_max_transition 0.5 [current_design]
