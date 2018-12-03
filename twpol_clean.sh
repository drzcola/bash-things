#!/bin/bash

for f in $(grep "Filename:" no-directory.txt | cut -f2 -d:); do
		sed -i "s|\($f\) |#\\1|g" /etc/tripwire/twpol.txt
done
