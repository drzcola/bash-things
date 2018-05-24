#!/bin/bash

CURRENT1=$(df /mnt/grabaciones | grep /mnt/grabaciones | awk '{ print $5 }' | sed 's/%//g')
CURRENT2=$(df /mnt/grabaciones_espejo | grep /mnt/grabaciones_espejo | awk '{ print $5 }' | sed 's/%//g')
CURRENT3=$(df /mnt/espejo | grep /mnt/espejo | awk '{ print $5 }' | sed 's/%//g')
CURRENT4=$(df /mnt/grabaciones_archivo | grep /mnt/grabaciones_archivo | awk '{ print $5 }' | sed 's/%//g')

echo "Ocupación actual de partición /mnt/grabaciones: $CURRENT1%." >> /tmp/informe_ocupacion
echo "Ocupación actual de partición /mnt/grabaciones_espejo: $CURRENT2%." >> /tmp/informe_ocupacion
echo "Ocupación actual de partición /mnt/espejo: $CURRENT3%." >> /tmp/informe_ocupacion
echo "Ocupación actual de partición /mnt/grabaciones_archivo: $CURRENT4%." >> /tmp/informe_ocupacion
