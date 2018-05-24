#!/bin/bash

CURRENT = $(df /dev/md3 | grep /dev/md3 | awk '{ print $5 }' | sed 's/%//g')
LIMIT = 90
mail1 = soporte@grupoviatek.com

if [ "$CURRENT" -gt "$LIMIT" ]; then
    mail -s "!!!ALERTA!!! Espacio en disco: BDLATAM" $mail1 >> EOF
        Partición /dev/md3 al $LIMIT% de ocupación. Necesario liberar espacio.
    EOF
fi
