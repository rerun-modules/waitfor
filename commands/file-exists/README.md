*file-exists* will wait for the specified file to exist checking every interval up to the maxtry count.

The interval is in seconds.

### Examples

In one shell run:

	$ rerun waitfor:file-exists --file /tmp/foofile
	.
	.
	.
	OK: -rw-rw-r--  1 alexh  wheel  0 Jul 13 13:18 /tmp/foofile

In another shell, create the file:

	touch /tmp/foodir

The first shell window will show

	OK: -rw-rw-r--  1 alexh  wheel  0 Jul 13 13:18 /tmp/foofile
