#!/bin/bash

var1="$(/usr/bin/cmus-remote -C 'status' | grep -E 'title' | cut -d ' ' -f2-20)"
var2="$(/usr/bin/cmus-remote -C 'status' | grep -E 'album' | cut -d ' ' -f2-20)"

title="$(echo $var1 | sed -n 's/^.*title//p')"
album="$(echo $var2 | sed -n 's/^.*\<album\>//p' | sed -e 's/albumartist.*$//g')"
artist="$(echo $var2 | sed -n 's/^.*\<albumartist\>//p' | sed -e 's/title.*$//g' | sed -e 's/album.*$//g')"

echo "***********"
echo "NOW PLAYING"
echo "***********"
echo ""
echo "Title: " $title
echo "Album: " $album
echo "Artist: " $artist
