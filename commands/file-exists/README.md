*file-exists* will wait for the specified file to exist checking every interval up to the maxtry count.

The interval is in seconds.

### Examples

In a shell run:

    $ (sleep 20 && touch /tmp/foofile) &
    [1] 10621
	$ rerun waitfor:file-exists --file /tmp/foofile --interval 1 --maxtry 30
	.
	.
	.
	OK: -rw-rw-r--  1 alexh  wheel  0 Jul 13 13:18 /tmp/foofile


Each dot represents a test for the conditon and will the interval length will elapse before the next dot.
When the file exists, a line like below will indicate "OK" plus file info.

	OK: -rw-rw-r--  1 alexh  wheel  0 Jul 13 13:18 /tmp/foofile
