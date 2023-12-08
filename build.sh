#!/usr/bin/env bash

# print a message and exit the script
function fail {
	printf '%s\n' "$1" >&2; exit "${2-1}"
}

# Change this depending on where you put llvm
LLVM='/usr/local/llvm-6.0'

# Kill the whole script on Ctrl+C
trap "exit" INT

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

grep "etc\/dynamatic" <(echo "$SCRIPT_DIR") \
	|| fail "error - the path name should be \$DHLS_INSTALL_DIR/etc/dynamatic!"

[ -x $LLVM/bin/clang ] \
	|| fail "error - the path $LLVM appears to not be the correct location of llvm!"

cd ${SCRIPT_DIR}/elastic-circuits &&
mkdir -p _build && cd _build &&
cmake .. -DLLVM_ROOT=${LLVM} && make clean && make -j$(nproc)

cd ${SCRIPT_DIR}/Buffers && mkdir -p bin && make clean && make -j$(nproc)

cd ${SCRIPT_DIR}/dot2hdl && mkdir -p obj/VHDL obj/Verilog obj/shared bin && make clean && make -j$(nproc)

cd ${SCRIPT_DIR}/dot2vhdl && mkdir -p bin && make clean && make -j$(nproc)

cd ${SCRIPT_DIR}/Regression_test/hls_verifier/HlsVerifier && mkdir -p build && make clean && make -j$(nproc)

cd ${SCRIPT_DIR}/bin && chmod +x ./*

cd ${SCRIPT_DIR}/../.. && {
	echo "export PATH=\$PATH:$(pwd)/etc/dynamatic/bin"
	echo "export PATH=\$PATH:$(pwd)/etc/dynamatic/Buffers/bin"
	echo "export PATH=\$PATH:$(pwd)/etc/dynamatic/dot2hdl/bin"
	echo "export PATH=\$PATH:$(pwd)/etc/dynamatic/dot2vhdl/bin"
	echo "export PATH=\$PATH:$(pwd)/etc/dynamatic/Regression_test/hls_verifier/HlsVerifier/build/"
	echo "export DHLS_INSTALL_DIR=$(pwd)"
	echo "export OPT_DIR=${LLVM}/bin"
	echo "export CLANG_DIR=${LLVM}/bin"
	echo "export ELASTIC_DIR=$(pwd)/etc/dynamatic/elastic-circuits"
} > init_dhls.sh

