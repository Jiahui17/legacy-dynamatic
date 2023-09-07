# The Dynamatic HLS Compiler

For official repository please checkout https://github.com/lana555/dynamatic

## Installation (Tested on Ubuntu/Debian based distributions)

Install dependencies:
```sh
sudo apt-get install -y build-essential \
	g++ cmake git pkg-config \
	coinor-cbc \
	graphviz graphviz-dev \
	xdot libxdot4 python3.8*

# install boost library
wget https://boostorg.jfrog.io/artifactory/main/release/1.82.0/source/boost_1_82_0.tar.gz
cd boost_1_82_0
./bootstrap.sh
sudo ./b2 install
```

Build LLVM (version 6.0), note that this will install llvm in
`/usr/local/llvm-6.0`, this location is hardcoded in the `build.sh` script,
remember to change it when you need to install LLVM in a different location:

```sh
git clone http://github.com/llvm-mirror/llvm --branch release_60 --depth 1
cd llvm/tools
git clone http://github.com/llvm-mirror/clang --branch release_60 --depth 1
git clone http://github.com/llvm-mirror/polly --branch release_60 --depth 1
cd ..
mkdir _build && cd _build
$CMAKE .. -DCMAKE_BUILD_TYPE=Debug \
	-DLLVM_INSTALL_UTILS=ON \
	-DLLVM_TARGETS_TO_BUILD="X86" \
	-DCMAKE_INSTALL_PREFIX=/usr/local/llvm-6.0

make # not recommended to enable parallel build
sudo make install
```

Clone this repo:
```
INSTALL_DIR=$HOME
mkdir -p $INSTALL_DIR/Dynamatic/etc
git clone https://github.com/Jiahui17/dynamatic.git $INSTALL_DIR/Dynamatic/etc/dynamatic
cd $INSTALL_DIR/Dynamatic/etc/dynamatic && bash build.sh
```

## Regression Test

Dynamatic provides a comprehensive regression test. Please refer to `./Regression_test/readme.md`


## Project Map

`elastic-circuits`: A collection of LLVM passes which input a C/C++ program and
transform its IR into a dataflow circuit. The output of this pass is a .DOT
file which represents a netlist of dataflow components. 

`Buffers`: Buffer placement for throughput and critical path optimization.
Inputs the .DOT netlist from *elastic-circuits* and outputs a .DOT netlist with
buffers placed and sized to maximize throughput under a given clock period
constaint.

`dot2vhdl/dothdl`: Inputs a .DOT netlist (either produced by
*elastic-circuits*, or by *Buffers*) and outputs an equivalent VHDL netlist of
dataflow components. VHDL descriptions of the dataflow components are given in
*components*. Apart from the VHDL netlist, *dot2vhdl* also produces a .json
file for configuring LSQs (if required by the design). The LSQ can be
configured using the files in *chisel_lsq*.

`bin`: it contains wrapper scripts for the compilation flow.

`data`: dataflow unit characterization (delay, latency) used by *Buffers*.

`Regression_test`: for testing purpose, `Regression_test/examples` contains a
suite of benchmarks used to evaluate dynamic scheduling.

`components`: VHDL/Verilog implementation of the dataflow units, wrapper
modules for interfacing with Xilinx floating point IPs.

`chisel_lsq`: LSQ generator written in *chisel*.

`build.sh`: a push-button solution for building Dynamatic.

