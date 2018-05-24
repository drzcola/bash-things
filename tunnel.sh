#!/bin/bash

echo -e "SSH Tunneling\n"
echo -n "IP: "
read ip
echo -n "Port: "
read port
echo -n "Key: "
read key

ssh -i /home/jruiz/soporte/gongora/llaves/$key -p $port -l root -D 8080 $ip
