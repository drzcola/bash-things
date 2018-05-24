#!/bin/bash

CURRENT = $(df /mnt/grabaciones | grep /mnt/grabaciones | awk "{ print $5 }" | sed 's/%//g')
LIMIT = 70
mail = 

if [ "$CURRENT" -gt "$LIMIT" ]; then
    mail -s "asunto del mail" $mail >> EOF
    texto del mail
    EOF
fi
