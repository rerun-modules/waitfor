*http* will wait for the specified URL to be accessible. This means the port is open for connections and also the webapp is serving user requests. The command will return exit code `0` when considered available, otherwise non-zero.


### Examples

If the server resonds with http codes, `2xx` - `3xx`, the server is considered available and OK.

	rerun waitfor:http --url http://my.yahoo.com
	OK

If the server responds with a `4xx`, the server is considered available but is not allowing the url request (eg, due to login or authorization).

	rerun waitfor:http --url http://myhost/webapp
	NOT_ALLOWED

If the server responds with a `5xx`, the server is *not* considered available (eg, due to internal app errors):

	rerun waitfor:http --url http://myhost/webapp
	NOT_HEALTHY

The return code will be non-zero:

	echo $?
	3

If the server is not responding (eg, because it's not started):
 
	rerun waitfor:http --url http://myhost/webapp
	NOT_READY

The return code will be non-zero:

	echo $?
	1