#!/bin/bash

status=$(dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'PlaybackStatus') 
statusClean=$(echo $status | cut -d'"' -f2)
dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.PlayPause > /dev/null

if [ "$statusClean" == "Playing" ]; then
    echo "PAUSE"
else
    echo "PLAY"
    echo " "
    /opt/bin/getinfo
fi
