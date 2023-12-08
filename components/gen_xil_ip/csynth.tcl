# generate wrappers for floating point units we still need to add additional
# wrapper to make them elastic
open_project -reset prj_dynamatic_units_6ns
set_top dynamatic_units_6ns
add_files dynamatic_units_6ns.c
add_files -tb dynamatic_units_6ns.c
open_solution -reset "solution"
set_part {xc7k160tfbg484-1}
create_clock -period 6.000 -name default
csim_design
csynth_design
cosim_design -rtl vhdl
cosim_design -rtl verilog
exit 
