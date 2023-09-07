#!/usr/bin/env bash

# Kill the whole script on Ctrl+C
trap "exit" INT

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd $SCRIPT_DIR

RUN_DHLS="bash $SCRIPT_DIR/run_dhls.sh"

# each example has up to 1000s (synthesis and simulation)
# it is timed out after this duration
TIMEOUT_DURATION='1500s'

xargs -r -i -a filelist.lst -n 1 -P 4 \
	bash -c "cd ./examples/{} && timeout $TIMEOUT_DURATION $RUN_DHLS"
