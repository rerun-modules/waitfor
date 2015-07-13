#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p seconds [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "seconds"


it_wait_1_second() {
	# TODO: 
    timeout 2 rerun waitfor:seconds --interval 1
}


