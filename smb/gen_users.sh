#!/bin/bash

counter=100

while IFS='' read -r line || [[ -n "$line" ]]; do
    nombre=$(echo $line | cut -d' ' -f1)
    apellido=$(echo $line | cut -d' ' -f2)
    echo gv_$nombre\_$apellido $counter
    let "counter++"
done < "$1"
