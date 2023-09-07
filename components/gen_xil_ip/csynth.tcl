# generate wrappers for floating point units we still need to add additional
# wrapper to make them elastic
open_project -reset prj_dynamatic_units
set_top dynamatic_units
add_files dynamatic_units.c
add_files -tb dynamatic_units.c
open_solution -reset "solution"
set_part {xc7k160tfbg484-1}
create_clock -period 4.000 -name default
csim_design
csynth_design
cosim_design -rtl vhdl
cosim_design -rtl verilog
exit 
