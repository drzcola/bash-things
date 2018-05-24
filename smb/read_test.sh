#!/bin/bash

while read USER COUNTER ; do
    echo "user" $USER
    echo "counter" $COUNTER
done < "$1"
