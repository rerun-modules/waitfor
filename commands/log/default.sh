#!/usr/bin/env bash
#
# NAME
#
#   log
#
# DESCRIPTION
#
#   wait for patterns in log file
#

# Read module function library
source $RERUN_MODULES/waitfor/lib/functions.sh || { echo "Failed loading function library" >&2 ; exit 1 ; }

# Parse the command options
[ -r $RERUN_MODULES/waitfor/commands/log/options.sh ] && {
    source $RERUN_MODULES/waitfor/commands/log/options.sh || exit 2 ;
}

# Exit immediately upon non-zero exit. See [set](http://ss64.com/bash/set.html)
#set -e


# ------------------------------
[ -z "$FAILURE_REGEX" -a -z "$SUCCESS_REGEX" ] && {
    echo >&2 "missing required option: --failure_regex and/or --success_regex"
    exit 2
}

if [ -n "$FILE" ]
then
    MONITOR_FILE=$(mktemp /tmp/waitfor:log-$(basename $FILE)-XXXXXXXXXX) || rerun_die "Error creating scratch file"
else
    MONITOR_FILE=$(mktemp /tmp/waitfor:log-stdin-XXXXXXXXXX) || rerun_die "Error creating scratch file"
fi



asyncTail() {
    (tail -n+0 -F ${FILE}) > "$MONITOR_FILE" &
    echo $!
}

cleanup() {
    kill -9 $jobPid >/dev/null 2>&1
    rm -f "$MONITOR_FILE"
}


jobPid=$(asyncTail)
[ -z "${jobPid}" ] && rerun_die "unable to tail file: ${FILE}"


let count=0
while true
do
    if [ -n "$FAILURE_REGEX" ]; then
        grep -n "${FAILURE_REGEX}" "$MONITOR_FILE" >&2 && {
            echo "FAIL: matched $FAILURE_REGEX"
            cleanup
            exit 1
        }
    fi
    if [ -n "$SUCCESS_REGEX" ]; then
        grep -n "${SUCCESS_REGEX}" "$MONITOR_FILE" >&2 && {    
            echo "SUCCESS: matched $SUCCESS_REGEX" 
            cleanup
            exit 0
        }
    fi

    let count=$count+1
    [  "$PROGRESS" == "true" ] && show_progress $count $MAXTRIES
    [ $count -eq $MAXTRIES ] && {
        echo "FAIL: No matches found after $MAXTRIES attempts" >&2
        cleanup
        exit 1
    }
    sleep ${INTERVAL}


done

cleanup

# ------------------------------

exit $?

# Done
