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
    rerun waitfor:ping --host localhost
}


