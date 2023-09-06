#!/usr/bin/env bash

# Kill the whole script on Ctrl+C
trap "exit" INT

# directory while the script is
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

(
	echo "List of passed benchmarks"
	find . -name 'hls_verify.log' -exec \
		bash -c "grep -q 'Comparison of.*Pass' {} && echo {}' result(s) ok!'"  \; | sort
	echo "------------------------------------"

	echo "List of failed benchmarks"
	find . -name 'hls_verify.log' -exec \
		bash -c "grep -q 'Comparison of.*Fail' {} && echo {}' result(s) incorrect!'"  \; | sort

	find . -name 'hls_verify.log' -exec \
		bash -c "grep -q 'Comparison of.*' {} || echo {}' result(s) missing!'"  \; | sort
	echo "------------------------------------"

	echo 'List of missing benchmarks'
	(cd examples; find . -maxdepth 1 -type d -not -path '.' \
		-exec bash -c "[ -f {}/reports/hls_verify.log ] || echo {}' not tested yet!'" \;) | sort
	echo "------------------------------------"

	echo 'MILP Runtimes'
	find . -name 'buffers.log' -exec \
		grep -H 'Total MILP' {} \; | sort


) | tee results.log
