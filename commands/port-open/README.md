*port-open* will wait for the specified port is open and accepting connections. 

The command will exit with `0` if the port is open otherwise non-zero.

### Examples

Check if localhost has something listening on port 8080

	rerun waitfor:port-open --host localhost --port 8080
	Connection to localhost port 8080 [tcp/*] succeeded!


Check if localhost has something listening on port 8083 (nothing is):

	rerun waitfor:port-open --host localhost --port 8083
	ERROR: Could not connect to localhost:8081
