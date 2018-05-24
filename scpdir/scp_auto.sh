#!/bin/bash

keys='/home/jruiz/soporte/gongora/llaves'
ipfile='listado_ip.txt'
echo -n "Ticket: "
read dir
mkdir -v ticket$dir
touch ticket$dir/ok.txt
touch ticket$dir/fail.txt

while read -r IP
do
    echo 'Probando puerto 22...'
    /usr/bin/nc -z -w5 $IP 22

    if [ $? -eq 0 ]; then
        echo $IP - OK por puerto 22 >> ticket$dir/ok.txt
        /usr/bin/scp -r -o StrictHostKeyChecking=no -P 22 vivanta-locuciones root@$IP:/var/spool/asterisk
    else
        echo Sin acceso por puerto 22. Probando puerto 33...
        /usr/bin/nc -z -w5 $IP 33
        if [ $? -eq 0 ]; then
            echo $IP - OK por puerto 33 >> ticket$dir/ok.txt
            /usr/bin/scp -r -o StrictHostKeyChecking=no -P 33 vivanta-locuciones root@$IP:/var/spool/asterisk
        else
            echo $IP - Sin acceso por puerto 22 o 33 >> ticket$dir/fail.txt
        fi
    fi
done < $ipfile
