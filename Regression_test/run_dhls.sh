#!/bin/env bash
function fail {
	printf '[ERROR] %s\n' "$1" >&2 # message to stderr
	exit "${2-1}"          # return code specified by $2, or 1 by default
}

# top-level file (remember to change these variables accordingly)
PROJ_DIR="$(realpath .)"
PROJ_NAME=$(basename $(ls ${PROJ_DIR}/src/*.cpp| head -1) | sed 's/.cpp//g')
TOP_FILE="${PROJ_NAME}.cpp"

# Kill the whole script on Ctrl+C
trap "exit" INT

# clock period
for i in "$@"; do
	case $i in
	-c=*|--clock_period=*|-period=*)
	CLOCK_PERIOD="${i#*=}"
	shift ;;
	*) ;;
	esac
done

# actual path of the dynamatic directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source $SCRIPT_DIR/../../../init_dhls.sh \
	|| fail "failed to source the environment, did you successfully build dynamatic?"

DEFAULT_PERIOD=6

[ -z "$CLOCK_PERIOD" ] && \
	echo "info - clock period is not set: using default cp=${DEFAULT_PERIOD}" && \
	CLOCK_PERIOD=${DEFAULT_PERIOD}

mkdir -p "$PROJ_DIR/reports"

# run the elastic pass
echo "info - Start synthesize."
compile "${TOP_FILE}" "${PROJ_DIR}" 2>&1 \
	| tee "$PROJ_DIR/reports/elastic_pass.log" \
	|| fail "error - elastic pass failed!"


source /opt/gurobi*/grbenv.sh && LP_SOLVER=gurobi_cl || LP_SOLVER=cbc

# run buffer pass
echo "info - Start optimize."
buffers buffers \
	-filename="${PROJ_DIR}/reports/${PROJ_NAME}" \
	-period=${CLOCK_PERIOD} -solver=$LP_SOLVER -timeout=360 2>&1 \
	| tee "${PROJ_DIR}/reports/buffers.log" \
	|| fail 'error - buffers failed!'

mv "${PROJ_DIR}/reports/${PROJ_NAME}"{_graph_buf,_optimized}.dot

# remove all the temporary files for MILP
rm $PROJ_DIR/*.{lp,gsol}

# remove the delay characterization files
rm delays_output.txt tmp_delays.txt

# convert the dot netlist to hdl netlist
echo "info - Start write hdl netlist"
write_hdl "${PROJ_DIR}" "${PROJ_DIR}/reports/${PROJ_NAME}_optimized" \
	|| fail "error - write_hdl failed!"

# output the visualization in pdf format
dot -O -Tpdf "${PROJ_DIR}"/reports/*.dot

# perform functional verification
mkdir -p "${PROJ_DIR}/sim/"{C_SRC,VHDL_SRC,REF_OUT,HLS_VERIFY,INPUT_VECTORS,VHDL_OUT}

# root directory of verify project
VERIFY_DIR="${PROJ_DIR}/sim"

# copy the c++ source code into directory C_SRC
cp "${PROJ_DIR}"/src/*.{cpp,h} "${VERIFY_DIR}"/C_SRC 2> /dev/null

# copy the hdl source code into directory VHDL_SRC
cp "${PROJ_DIR}"/hdl/* "${VERIFY_DIR}"/VHDL_SRC 2> /dev/null

rm -r "${PROJ_DIR}/sim/HLS_VERIFY/work" 2> /dev/null

# verifier requires you to be in HLS_VERIFY directory to work
cd "${PROJ_DIR}/sim/HLS_VERIFY"

# run the verifier and save the log
hlsverifier \
	cover -aw32 "../C_SRC/${TOP_FILE}" \
	"../C_SRC/${TOP_FILE}" "${PROJ_NAME}" 2>&1 \
	| tee ${PROJ_DIR}/reports/hls_verify.log \
	|| fail 'hlsverifier failed!'
