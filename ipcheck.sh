#!/bin/bash

currentip = $(curl icanhazip.com)
lastip = $(cat jose_ip.log)
mail = jose.ruiz@grupoviatek.com

if [ "$currentip" != "$lastip" ]; then
    echo $currentip | mail -s "..." $mail
    echo $currentip > /root/jose_ip.log
fi
