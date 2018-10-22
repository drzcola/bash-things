#!/bin/sh

date=`date +%Y%m%d`
ipaddr="189.8.74.57"

sshpass -p filkokpa20\!8 scp -o StrictHostKeyChecking=no /tmp/test.txt root@$ipaddr:/tmp/

