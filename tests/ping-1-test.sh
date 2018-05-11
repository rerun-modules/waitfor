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

# TODO: when ping no longer requires SUID, turn on for travis.
# Believe it or not, you can't run ping on travis when in a docker image.
# https://github.com/travis-ci/travis-ci/issues/3080


it_succeeds_if_reachable() {

    [[ -n "${TRAVIS_BUILD_NUMBER:-}" ]] && return 0
    timeout 10 rerun waitfor:ping --host localhost
    result=$(rerun waitfor:ping --host localhost)
    test "$result" = "OK: localhost is pingable."
}


it_fails_if_unreachable() {
    [[ -n "${TRAVIS_BUILD_NUMBER:-}" ]] && return 0
    if ! result=$(rerun waitfor:ping --host bogusbogeeeey --maxtry 1 --interval 1 2>&1)
    then
		grep "Reached max tries: 1. Could not ping host bogusbogeeeey. Exiting." <<< "$result"
	else
		return 1; # did not properly fail
	fi
}
