#!/bin/bash

CURRENT = $(df /home | grep /home | awk "{ print $5 }" | sed 's/%//g')
LIMIT = 5
mail = jose.ruiz@grupoviatek.com

if [ "$CURRENT" -gt "$LIMIT" ]; then
    mail -s "Prueba HDD LIMIT" $mail >> EOF
    Partición /home al $CURRENT% de ocupación.
    EOF
fi
