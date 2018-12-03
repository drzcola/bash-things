#!/bin/bash

# -- ---------------------------------------------------------------------------------------------
# --                                      DAILY CHECKLIST                                          
# -- FECHA: 2018-11-27             AUTOR: Jose Ruiz            CONTACTO: jose.ruiz@grupoviatek.com
# -- ---------------------------------------------------------------------------------------------
# -- DESCRIPCION:
# -- Script para automatizar buena parte de las tareas a realizar de manera diaria en la revision
# -- de los servidores de Kronotek Brasil.
# -- * VERSION DE CENTRALITA INDEPENDIENTE *
# -- ---------------------------------------------------------------------------------------------

hostname=`hostname`
strg_home=`df -h | grep -w "/home" | tr -s ' ' | cut -d' ' -f4`
total_home=`df -h | grep -w "/home" | tr -s ' ' | cut -d' ' -f2`
strg_root=`df -h | grep -w "/" | tr -s ' ' | cut -d' ' -f4`
total_root=`df -h | grep -w "/" | tr -s ' ' | cut -d' ' -f2`
strg_usb1=`df -h | grep -w "usb1" | tr -s ' ' | cut -d' ' -f4`
total_usb1=`df -h | grep -w "usb1" | tr -s ' ' | cut -d' ' -f2`
strg_usb2=`df -h | grep -w "usb2" | tr -s ' ' | cut -d' ' -f4`
total_usb2=`df -h | grep -w "usb2" | tr -s ' ' | cut -d' ' -f2`

echo "HOST: " $hostname
echo "Espacio en disco: "
echo "/    :" $strg_root "/" $total_root
echo "/home:" $strg_home "/" $total_home
echo "/usb1:" $strg_usb1 "/" $total_usb1
echo "/usb2:" $strg_usb2 "/" $total_usb2
echo -en "\n"
echo "Contenido del directorio /home/recording/temp: "
echo `ls /home/recording/temp`
echo -en "\n"
echo "Rutas estaticas: "
/sbin/ip route
echo -en "\n"
echo "Comunicacion con el servidor MRCP: "
if [[ $hostname == *"PULTR"* ]]; then
		ping -c 1 172.20.1.237
fi
if [[ $hostname == *"PVIVO"* ]]; then
		ping -c 1 192.168.10.2
fi
if [[ $hostname == *"NVIVO"* ]]; then
		ping -c 1 192.168.1.168
fi
