# Regression Test

## Directory Map

`regression_test.sh`: a batch script for running regression test.

usage: `bash ./regression_test.sh`

---

`run_dhls.sh`: a wrapper script for calling the bins of dynamatic, if you need
to change the default clock frequency (4 ns), use the following:

```sh
cd ./examples/fir && bash ../../run_dhls.sh -c=6
```

---
`filelist.lst`: a list of benchmarks to run regression test on. This file is
read by `regression_test.sh`.
```
fir
```

---

View the results:
```
bash ./report_results.sh

# hopefully this should tell you this :)
# ./examples/fir/reports/hls_verify.log:Comparison of [end] : Pass
```

## Running Synthesis using Vivado (v2019.1.1)

The script `run_vivado201911.py` writes the needed tcl scripts for Vivado, and
it runs the synthesis.

```sh 
cd ./examples/fir && python3 ../../../bin/run_vivado201911.py -clock=6
```
