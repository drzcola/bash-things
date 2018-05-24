#!/bin/bash

# Variable para el control mensual
mes=`date | awk '{print $2}'`

# Eliminar protección contra escritura en archivo
/usr/bin/chattr -i /etc/asterisk/extensions_gongora_entrantes.conf

# Copiar archivo de entrantes correspondiente a $mes
/bin/cp /root/entrantes_$mes.conf /etc/asterisk/extensions_gongora_entrantes.conf

# Protección contra escritura 
/usr/bin/chattr +i /etc/asterisk/extensions_gongora_entrantes.conf

# Recarga de dialplan
/usr/sbin/asterisk -rx 'dialplan reload'

