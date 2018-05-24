#!/bin/bash

filename="$1"
counter="0"

while read -r line
do
    name="$line"
    let "counter++"
    echo "Line $counter - $line"
done < "$filename"
