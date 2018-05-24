#!/bin/bash

ipfile='listado_ip.txt'

while read -r IP
do
    echo 'Probando puerto 22...'
    /usr/bin/nc -z -w5 $IP 22

    if [ $? -eq 0 ]; then
        echo $IP - OK por puerto 22 >> ivr/ok.txt
        echo 'OK por puerto 22'
        /usr/bin/scp -r -o StrictHostKeyChecking=no -P 22 vivanta-ivr.wav root@$IP:/var/spool/asterisk/locuciones
    else
        echo 'Probando puerto 33...'
        /usr/bin/nc -z -w5 $IP 33

        if [ $? -eq 0 ]; then
            echo $IP - OK por puerto 33 >> ivr/ok.txt
            echo 'OK por puerto 33'
            /usr/bin/scp -r -o StrictHostKeyChecking=no -P 33 vivanta-ivr.wav root@$IP:/var/spool/asterisk/locuciones
        else
            echo $IP - Sin acceso >> ivr/fail.txt
        fi
    fi
done < $ipfile
