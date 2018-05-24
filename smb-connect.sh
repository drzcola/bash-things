#!/bin/bash

# Check if user has root permissions
if [ $EUID -ne 0 ]; then
    echo "Missing root permissions!" 1>&2
    exit 1
fi

echo -n "IP: "
read ip
echo -n "Share: "
read share
echo -n "Username: "
read user
echo -n "Password: "
read -s pass

mount -t cifs //$ip/$share -o user=$user,password=$pass /mnt/smb
