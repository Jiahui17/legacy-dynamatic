# A Simple Setup for Generating Floating-Point IPs

## Usage:

We can simply run the csynth using `vivado_hls` (v2019.1), it takes some time to finish.

```sh
VIVADO_HLS='vivado-2019.1.1 vivado_hls'
$VIVADO_HLS csynth.tcl
```

The files to collect are in several locations, here are some files only needed for simulation (these files are only in vhd format):
``` 
dynamatic_units_ap_fadd_8_full_dsp_32.vhd
dynamatic_units_ap_fcmp_0_no_dsp_32.vhd
dynamatic_units_ap_fdiv_28_no_dsp_32.vhd
dynamatic_units_ap_fexp_16_full_dsp_32.vhd
dynamatic_units_ap_flog_17_full_dsp_32.vhd
dynamatic_units_ap_fmul_4_max_dsp_32.vhd
dynamatic_units_ap_fsqrt_26_no_dsp_32.vhd
dynamatic_units_ap_fsub_8_full_dsp_32.vhd
dynamatic_units_ap_sitofp_4_no_dsp_32.vhd
```

Here are some files for both simulation and synthesis: 
``` 
dynamatic_units_fadd_32ns_32ns_32_10_full_dsp_1.v
dynamatic_units_fcmp_32ns_32ns_1_2_1.v
dynamatic_units_fdiv_32ns_32ns_32_30_1.v
dynamatic_units_fexp_32ns_32ns_32_18_full_dsp_1.v
dynamatic_units_flog_32ns_32ns_32_19_full_dsp_1.v
dynamatic_units_fmul_32ns_32ns_32_6_max_dsp_1.v
dynamatic_units_fsqrt_32ns_32ns_32_28_1.v
dynamatic_units_fsub_32ns_32ns_32_10_full_dsp_1.v

dynamatic_units_ap_fadd_8_full_dsp_32_ip.tcl
dynamatic_units_ap_fcmp_0_no_dsp_32_ip.tcl
dynamatic_units_ap_fdiv_28_no_dsp_32_ip.tcl
dynamatic_units_ap_fexp_16_full_dsp_32_ip.tcl
dynamatic_units_ap_flog_17_full_dsp_32_ip.tcl
dynamatic_units_ap_fmul_4_max_dsp_32_ip.tcl
dynamatic_units_ap_fsqrt_26_no_dsp_32_ip.tcl
dynamatic_units_ap_fsub_8_full_dsp_32_ip.tcl
dynamatic_units_ap_sitofp_4_no_dsp_32_ip.tcl
```


