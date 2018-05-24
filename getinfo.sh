#/bin/bash

script="/usr/bin/python /home/jruiz/soporte/scripts/python/spotify_getinfo.py"
album=$($script | grep album)
albumClean=$(echo $album | cut -d':' -f2)
title=$($script | grep title)
titleClean=$(echo $title | cut -d':' -f2)
track=$($script | grep trackNumber)
trackClean=$(echo $track | cut -d':' -f2)

echo "Now playing: "
echo ""
echo "Album: " $albumClean | sed 's/album//g'
echo "Title: " $titleClean | sed 's/title//g'
#echo "Track: " $trackClean | sed 's/trackNumber//g'
