#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p check-result [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "check-result"

it_succeeds_immediately_if_check_is_correct() {
    timeout 1 rerun waitfor:check-result --check "echo Its OK" --result "Its OK"
}

it_succeeds_immediately_if_check_is_another_result_negative() {
    timeout 1 rerun waitfor:check-result --check "echo Its OK" --result "Not is OK" --negative "True"
}

it_fail_if_check_return_other_value() {
    if ! timeout 5 rerun waitfor:check-result --check "echo Not is OK" --result "Its OK" --interval 1 
    then
       echo >&2 "TEST: properly failed. exit code $?"
    else
        echo >&2 "TEST: Should have failed."
        exit 1
    fi
 
}

it_fail_if_check_return_the_same_value_negative() {
    if ! timeout 5 rerun waitfor:check-result --check "echo Its OK" --result "Its OK" --interval 1 --negative "True"
    then
       echo >&2 "TEST: properly failed. exit code $?"
    else
        echo >&2 "TEST: Should have failed."
        exit 1
    fi
 
}

it_succeeds_after_5s_when_the_check_is_like_the_expected() {
    FILE=/tmp/it_succeeds_after_5s_when_the_check_is_like_the_expected.$$
    echo 0 > ${FILE}
    ( sleep 5 && echo 1 > $FILE ) &

    if ! timeout 5 rerun waitfor:check-result --check "cat ${FILE}" --result "1" --interval 5
    then
    	echo >&2 "TEST: properly failed. exit code $?"
    else
    	echo >&2 "TEST: Should have failed."
    	rm -f $FILE
    	exit 1
    fi
    rm -f $FILE
}

it_succeeds_after_5s_when_the_check_is_different_than__the_expected_negative() {
    FILE=/tmp/it_succeeds_after_5s_when_the_check_is_like_the_expected.$$
    echo 0 > ${FILE}
    ( sleep 5 && echo 1 > $FILE ) &

    if ! timeout 5 rerun waitfor:check-result --check "cat ${FILE}" --result "0" --interval 5 --negative "True"
    then
    	echo >&2 "TEST: properly failed. exit code $?"
    else
    	echo >&2 "TEST: Should have failed."
    	rm -f $FILE
    	exit 1
    fi
    rm -f $FILE
}
