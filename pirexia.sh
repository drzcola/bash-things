#!/bin/bash

ssh -p 33 -i /home/jruiz/soporte/gongora/llaves/soporte -f -N -L 5555:127.0.0.1:80 root@pirexia.gongoraip.com
