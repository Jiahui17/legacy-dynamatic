#!/usr/bin/env bash

# Kill the whole script on Ctrl+C
trap "exit" INT

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

RUN_DHLS="bash $SCRIPT_DIR/run_dhls.sh"

while read dirname; do
	echo "Running regression test for example/$dirname"
	(cd examples/$dirname; $RUN_DHLS)
done < filelist.lst
