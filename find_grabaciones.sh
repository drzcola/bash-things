#!/bin/bash

echo -n "Path: "
read path
echo -n "Filename: "
read filename
echo -n "Start limit: "
read start
echo -n "End limit: "
read end

find $path -type f -name "$filename" -newermt $start ! -newermt end -ls
