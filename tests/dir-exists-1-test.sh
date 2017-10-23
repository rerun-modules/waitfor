#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p dir-exists [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "dir-exists"


it_succeeds_immiedately_if_dir_already_present() {
    DIR=$(mktemp -d "/tmp/it_succeeds_immiedately_if_dir_already_present.XXXX")
    timeout 1 rerun waitfor:dir-exists --dir "$DIR"

    rmdir "${DIR}"
}

it_fails_after_5s_when_dir_not_present() {
    DIR=/tmp/it_succeeds_after_5s_when_dir_becomes_present.$$
    ( sleep 8 && mkdir $DIR ) &

    if ! timeout 5 rerun waitfor:dir-exists --dir "${DIR}" --interval 1
    then
        local fc=$?
        kill %1
    	echo >&2 "TEST: properly failed. exit code ${fc}"
    else
    	echo >&2 "TEST: Should have failed."
        [[ -d "${DIR}" ]] && rmdir "${DIR}"
    	exit 1
    fi

    [[ -d "${DIR}" ]] && rmdir "${DIR}"
    exit 0
}

it_succeeds_after_3s_when_dir_created() {
    DIR=/tmp/it_succeeds_after_5s_when_dir_becomes_present.$$
    ( sleep 3 && mkdir $DIR ) &

    if timeout 5 rerun waitfor:dir-exists --dir "${DIR}" --interval 1
    then
    	echo >&2 "TEST: properly succeeded."
    else
    	echo >&2 "TEST: failed. exit code $?"
        [[ -d "${DIR}" ]] && rmdir "${DIR}"
    	exit 1
    fi

    [[ -d "${DIR}" ]] && rmdir "${DIR}"
    exit 0
}
