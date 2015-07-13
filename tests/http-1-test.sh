#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p url [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "http"


it_returns_OK() {
    OUT=$(rerun waitfor:http --url http://google.com)
    test "$OUT" = "OK"
}

it_returns_NOT_READY() {
    ! OUT=$(rerun waitfor:http --url http://localhost:9999)
    test "$OUT" = "NOT_READY"
}
