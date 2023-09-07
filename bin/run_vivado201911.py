#!/usr/bin/env python3
from pathlib import Path
from os.path import basename
from glob import glob
from argparse import ArgumentParser
import re, sys, subprocess

# where is the root for the entire project?
_DHLS_ROOT = Path(__file__).resolve().parents[1]

_TCL_DIR = _DHLS_ROOT / 'components' / 'tcl'

def get_arguments():

	proj_name = basename(glob('./src/*.cpp')[0]).replace('.cpp', '')

	parser = ArgumentParser()
	parser.add_argument('-name', type=str, default = proj_name)
	parser.add_argument('-clock', type=int, default = 6)
	return parser.parse_args()

def run(*args, **kwargs):
	sys.stdout.flush()
	return subprocess.run(*args,**kwargs,check=True) 


if __name__ == '__main__':

	# check if the directory is ready for synthesis
	if glob('./src') == []:
		raise ValueError('./src directory missing!')

	if glob('./hdl') == []:
		raise ValueError('./hdl directory missing!')

	args = get_arguments()

	for tcl in glob(str(_TCL_DIR / '*.tcl')):
		run(['cp', tcl , './hdl'])
	
	float_clock = f'{float(args.clock):.3f}'
	float_half_clock = f'{float(args.clock) / 2:.3f}'

	# write xdc file
	with open('./period.xdc', 'w') as f:
		text = '''
			create_clock -name clk -period ?CLOCK? -waveform {0.000 ?HALF_CLOCK?} [get_ports clk]
			set_property HD.CLK_SRC BUFGCTRL_X0Y0 [get_ports clk]
		'''

		text = re.sub(r'\?CLOCK\?', float_clock, text)
		text = re.sub(r'\?HALF_CLOCK\?', float_half_clock, text)
		f.write(re.sub(r'\t+','', text))


	with open('include_float.tcl', 'w') as f:
		text = '''
			source hdl/array_RAM_ap_fadd_8_full_dsp_32_ip.tcl
			source hdl/array_RAM_ap_fcmp_0_no_dsp_32_ip.tcl
			source hdl/array_RAM_ap_fdiv_28_no_dsp_32_ip.tcl
			source hdl/array_RAM_ap_fmul_4_max_dsp_32_ip.tcl
			source hdl/array_RAM_ap_fsqrt_26_no_dsp_32_ip.tcl
			source hdl/array_RAM_ap_fsub_8_full_dsp_32_ip.tcl
			source hdl/dynamatic_units_ap_sitofp_4_no_dsp_32_ip.tcl
		'''
		f.write(re.sub(r'\t+','', text))

	# write the synthesis file
	with open('./synthesis.tcl', 'w') as f:

		for vhdl in glob('./hdl/*.vhd'):
			f.write(f'read_vhdl -vhdl2008 {vhdl}\n')

		for verilog in glob('./hdl/*.v'):
			f.write(f'read_verilog {verilog}\n')
		text = '''
			read_xdc period.xdc 
			source include_float.tcl 
			synth_design -top TOP_DESIGN -part xc7k160tfbg484-1 -no_iobuf -mode out_of_context 
			opt_design
			place_design
			route_design
			report_utilization -hierarchical > synth_rpts/utilization_post_pr_hierarchical.rpt
			report_utilization > synth_rpts/utilization_post_pr.rpt
			report_timing > synth_rpts/timing_post_pr.rpt
			# Uncomment the line below to save the design checkpoint to file
			#write_checkpoint -force checkpoint_post_pr.dcp 
			exit
		'''
		text = re.sub('TOP_DESIGN', args.name, text)
		f.write(re.sub(r'\t+','', text))

	
	run(['mkdir', '-p', './synth_rpts'])
	run(['vivado-2019.1.1', 'vivado', '-mode', 'batch', '-source', './synthesis.tcl'])
