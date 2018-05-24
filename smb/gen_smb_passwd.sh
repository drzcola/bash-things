#!/bin/bash

while read USER PASSWD ; do
    (echo grupoviat3k$PASSWD; echo grupoviat3k$PASSWD) | smbpasswd -a -s ${USER}
done < "$1"
