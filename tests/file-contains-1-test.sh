#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p file-contains [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "file-contains"

it_succeeds_immediately_if_string_present() {
    FILE=$(mktemp "/tmp/it_succeeds_immiedately_when_file_already_present.XXXX")
    echo "FOO" > "${FILE}"
    timeout 1 rerun waitfor:file-contains --file "$FILE" --string FOO

    rm "${FILE}"
}
it_waits_until_string_present() {
    FILE=$(mktemp "/tmp/it_waits_until_string_present.XXXX")
    (sleep 5 && echo "FOO" > "${FILE}") &
    timeout 6 rerun waitfor:file-contains --file "$FILE" --string FOO --interval 5

    rm "${FILE}"
}

it_fails_when_maxtry_exceeded() {
    FILE=$(mktemp "/tmp/it_fails_when_maxtry_exceeded.XXXX")

    ! timeout 6 rerun waitfor:file-contains --file "$FILE" --string FOO --interval 5 --maxtry 1

	! timeout 6 rerun waitfor:file-contains --file "$FILE" --string FOO --interval 1 --maxtry 3
    rm "${FILE}"
}
