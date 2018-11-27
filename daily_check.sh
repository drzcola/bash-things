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
strg_root=`df -h | grep -w "/" | tr -s ' ' | cut -d' ' -f4`

echo "HOST: "
echo "Espacio en disco: "
echo "/    :" $strg_root
echo "/home:" $strg_home
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
