#!/bin/env bash
function fail {
	printf '%s\n' "$1" >&2 # message to stderr
	exit "${2-1}"          # return code specified by $2, or 1 by default
}

# if vsim is not in the default search path:
[ -x "$(which vsim)" ] || {
	export PATH=${PATH}:~/intelFPGA/21.1/questa_fse/bin/;
	export MGLS_LICENSE_FILE=~/intelFPGA/LR-090565_License.dat
}

# top-level file (remember to change these variables accordingly)
PROJ_DIR="."
PROJ_NAME=$(basename $(ls ${PROJ_DIR}/src/*.cpp| head -1) | sed 's/.cpp//g')
TOP_FILE="${PROJ_NAME}.cpp"

# Kill the whole script on Ctrl+C
trap "exit" INT

# actual path of the dynamatic directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/../../../../init_dhls.sh || fail "error - cannot initialize the env for dhls"

run_dhls | tee $PROJ_DIR/reports/run_dhls.log

run_verifier | tee $PROJ_DIR/reports/hls_verifier.log

exit 0 # comment out!
