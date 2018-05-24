#!/bin/bash

mail='martin.martinez@grupoviatek.com'
file='/tmp/informe_mensual.csv'

/usr/bin/mutt -a $file -s "Informe CDR GóngoraIP - `date +%Y-%m`" -- $mail < /dev/null

/bin/sleep 5

/bin/rm -rf /tmp/informe_mensual.csv
