*ping* will wait for the specified host to be reachable to ICMP.

The command will exit with `0` if the port is open otherwise non-zero.

### Examples

Check if localhost is reachable (of course):

	rerun waitfor:ping --host localhost
	OK: localhost is pingable.


Check if a down host is reachable (eg, it's still booting up):

	rerun waitfor:ping --host 192.168.50.2
	.
	.
	.
	OK: 192.168.50.2 is pingable.

