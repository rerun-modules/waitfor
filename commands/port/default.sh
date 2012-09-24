#!/usr/bin/env bash
#
# NAME
#
#   port
#
# DESCRIPTION
#
#   wait for port to reach listen state
#

# Read module function library
source $RERUN_MODULES/waitfor/lib/functions.sh || { echo "Failed loading function library" >&2 ; exit 1 ; }

# Parse the command options
[ -r $RERUN_MODULES/waitfor/commands/port/options.sh ] && {
    source $RERUN_MODULES/waitfor/commands/port/options.sh || exit 2 ;
}

# Exit immediately upon non-zero exit. See [set](http://ss64.com/bash/set.html)
#set -e


# ------------------------------
# Check for prerequisites

which nc >/dev/null 2>&1 || rerun_die "Command not found: nc"

let count=0
while true
do

    nc -v -z $(hostname) ${PORT} >/dev/null 2>&1 && {
      echo "OK: port ${PORT} is in LISTEN state" 
      exit 0
    }
    let count=$count+1
    [ -n "$PROGRESS" ] && show_progress $count $MAXTRIES

    [ $count -eq $MAXTRIES ] && {
        echo "FAIL: Reached max-retries: $MAXTRIES" >&2
        exit 1
    }
    sleep ${INTERVAL}


done

# ------------------------------

exit $?

# Done
