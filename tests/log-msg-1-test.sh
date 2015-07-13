#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p log-msg [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "log-msg"

# ------------------------------
# Replace this test. 
it_fails_without_a_real_test() {
    exit 1
}
# ------------------------------

