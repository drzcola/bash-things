#!/bin/bash

mail=jose.ruiz@grupoviatek.com
client=''

/usr/bin/mail -s "$client - Informe de ocupación `date`" $mail < /tmp/informe_ocupacion

/bin/echo "" > /tmp/informe_ocupacion
