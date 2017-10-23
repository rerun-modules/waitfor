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


# TODO: when ping no longer requires SUID, turn on for travis
it_reaches_localhost() {
    # believe it or not, you can't run ping on travis when in a docker image
    # https://github.com/travis-ci/travis-ci/issues/3080
    [[ -n "${TRAVIS_BUILD_NUMBER:-}" ]] && return 0
    timeout 10 rerun waitfor:ping --host localhost
}


