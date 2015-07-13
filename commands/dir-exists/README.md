*dir-exists* will wait for the specified directory to exist checking every interval up to the maxtry count.

The interval is in seconds.

### Examples

In one shell run:
	$ rerun waitfor:dir-exists --dir /tmp/foodir
	.
	.
	.
	OK: drwxrwxr-x  2 alexh  wheel  68 Jul 13 13:17 /tmp/foodir

In another shell, create the directory

	mkdir /tmp/foodir

The first shell will print:

	OK: drwxrwxr-x  2 alexh  wheel  68 Jul 13 13:17 /tmp/foodir
