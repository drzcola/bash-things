#!/bin/bash

/usr/bin/scrot /tmp/lock.png
/usr/bin/convert -blur 0x4 /tmp/lock.png /tmp/lock_blur.png
/usr/local/bin/i3lock -i /tmp/lock_blur.png
