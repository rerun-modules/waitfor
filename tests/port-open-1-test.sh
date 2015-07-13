#!/usr/bin/env roundup
#
#/ usage:  rerun stubbs:test -m waitfor -p port-open [--answers <>]
#

# Helpers
# -------
[[ -f ./functions.sh ]] && . ./functions.sh

# The Plan
# --------
describe "port-open"


it_finds_port_80() {
    rerun waitfor:port-open --host google.com --port 80
}


it_waits_for_custom_port() {
	CUSTOM_PORT=55224; # TODO: use better way to choose random free port

	(timeout 5 nc -l $CUSTOM_PORT) &
	rerun waitfor:port-open --host localhost --port $CUSTOM_PORT --interval 1 

}