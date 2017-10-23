#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p ping [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "ping"


it_reaches_localhost() {
    timeout 10 rerun waitfor:ping --host 127.0.0.1
}


