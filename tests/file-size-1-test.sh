#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p file-size [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "file-size"

it_succeeds_immediately_if_already_size() {
    FILE=$(mktemp "/tmp/it_succeeds_immediately_if_already_size.XXXX")
    echo "12345" > $FILE
    timeout 1 rerun waitfor:file-size --file "$FILE" --bytes 6

    rm $FILE
}
it_waits_until_size() {
    FILE=$(mktemp "/tmp/it_waits_until_size.XXXX")
    (sleep 5 && echo "12345" > $FILE) &
    timeout 6 rerun waitfor:file-size --file "$FILE" --bytes 6 --interval 1

    rm $FILE
}

it_fails_when_maxtry_exceeded() {
    FILE=$(mktemp "/tmp/it_fails_when_maxtry_exceeded.XXXX")

    ! timeout 6 rerun waitfor:file-size --file "$FILE" --bytes 6 --interval 5 --maxtry 1

	! timeout 6 rerun waitfor:file-size --file "$FILE" --bytes 6 --interval 1 --maxtry 3
    rm $FILE
}
