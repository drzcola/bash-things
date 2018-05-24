#!/bin/bash

trunk=311001
mail=soporte@grupoviatek.com

/usr/sbin/asterisk -rx 'sip show peers' | grep 311001 | grep UNREACHABLE

status=$(echo $?)

if [ "$status" -eq 1 ]; then
    echo "Troncal $trunk caído" | mail -s "!!!URGENTE: Troncal caído!!!" $mail
fi
