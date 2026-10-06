###################################################################

# Created by write_sdc on Tue Oct  6 16:06:09 2026

###################################################################
set sdc_version 2.2

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
create_clock [get_ports clk]  -period 208.333  -waveform {0 104.166}
