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

it_succeeds_immediately_if_check_is_not_correct() {
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

it_succeeds_after_5s_when_check_is_expected() {
    FILE=/tmp/it_succeeds_after_5s_when_check_is_expected.$$
    echo 0 > "${FILE}"
    ( sleep 5 && echo 1 > "${FILE}" ) &

    if timeout 8 rerun waitfor:check-result --check "cat ${FILE}" --result "1" --interval 2
    then
        echo >&2 "TEST: properly succeeded."
    else
        echo >&2 "TEST: Failed. exit code $?"
        rm -f $FILE
        exit 1
    fi
    rm -f $FILE
}

it_fails_after_6s_when_check_is_expected() {
    FILE=/tmp/it_fails_after_6s_when_check_is_expected.$$
    echo 0 > "${FILE}"
    ( sleep 5 && echo 1 > "${FILE}" ) &

    if ! timeout 6 rerun waitfor:check-result --check "cat ${FILE}" --result "2" --interval 1
    then
        echo >&2 "TEST: properly failed. exit code $?"
    else
        echo >&2 "TEST: Should have failed."
        rm -f $FILE
        exit 1
    fi
    rm -f $FILE
}

it_fails_after_2s_when_check_is_same_negative() {
    FILE=/tmp/it_fails_after_2s_when_check_is_same_negative.$$
    echo 0 > "${FILE}"

    if ! timeout 2 rerun waitfor:check-result --check "cat ${FILE}" --result "0" --interval 1 --negative "True"
    then
        echo >&2 "TEST: properly failed. exit code $?"
    else
        echo >&2 "TEST: Should have failed."
        rm -f "${FILE}"
        exit 1
    fi
    rm -f "${FILE}"
}

it_succeeds_after_5s_when_check_is_different() {
    FILE=/tmp/it_succeeds_after_5s_when_check_is_different.$$
    echo 0 > "${FILE}"
    ( sleep 5 && echo 1 > "${FILE}" ) &

    if timeout 8 rerun waitfor:check-result --check "cat ${FILE}" --result "0" --interval 2 --negative "True"
    then
        echo >&2 "TEST: properly succeeded."
    else
        echo >&2 "TEST: Failed. exit code $?"
        rm -f $FILE
        exit 1
    fi
    rm -f "${FILE}"
}
