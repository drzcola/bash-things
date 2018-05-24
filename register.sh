#!/bin/bash

echo -n "Extension: "
read extension

while [ "$extension" -ne "999" ]
do
    echo Extrayendo informacion de extension $extension
    grep "Registered SIP '$extension'" full* > /root/register_$extension.txt
done
