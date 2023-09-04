#!/usr/bin/env bash

# Kill the whole script on Ctrl+C
trap "exit" INT

# directory while the script is
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "List of passed benchmarks"
find . -name 'hls_verify.log' -exec \
	bash -c "grep -q 'Comparison of.*Pass' {} && echo {}' result(s) ok!'"  \;
echo "------------------------------------"

echo "List of failed benchmarks"
find . -name 'hls_verify.log' -exec \
	bash -c "grep -q 'Comparison of.*Fail' {} && echo {}' result(s) incorrect!'"  \;
echo "------------------------------------"

echo 'List of missing benchmarks'
(cd examples; find . -maxdepth 1 -type d -not -path '.' \
	-exec bash -c "[ -f {}/reports/hls_verify.log ] || echo {}' not synthesized'" \;)
echo "------------------------------------"
