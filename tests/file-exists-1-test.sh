#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p file-exists [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "file-exists"


it_succeeds_immiedately_if_file_already_present() {
    FILE=$(mktemp "/tmp/it_succeeds_immiedately_when_file_already_present.XXXX")
    timeout 1 rerun waitfor:file-exists --file "$FILE"

    rm $FILE
}

it_succeeds_after_5s_when_file_becomes_present() {
    FILE=/tmp/it_succeeds_after_5s_file_becomes_present.$$

    ( sleep 5 && touch $FILE ) &

    if ! timeout 5 rerun waitfor:file-exists --file "$FILE" --interval 5
    then
    	echo >&2 "TEST: properly failed. exit code $?"
    else
    	echo >&2 "TEST: Should have failed."
    	rm -f $FILE
    	exit 1
    fi
    rm -f $FILE
}


