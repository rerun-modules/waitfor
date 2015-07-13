*file-contains* will wait for the string to be contained in the specified file, checking every interval up to the maxtry count.

The interval is in seconds.

### Examples

In one shell run:

	$ rerun waitfor:file-contains --file /tmp/foofile --string foo 
	.
	.
	.
	foo

In another shell, add the word 'foo' to the file:

	echo "foo" >> /tmp/foodir

The first shell will have the line 

    foo	