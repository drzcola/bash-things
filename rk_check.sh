#!/bin/bash

server=""
mail=""

/usr/bin/rkhunter --nocolors --versioncheck > /tmp/rkhunter_report.txt
/usr/bin/rkhunter --nocolors --update >> /tmp/rkhunter_report.txt
/usr/bin/rkhunter --cronjob --report-warnings-only >> /tmp/rkhunter_report.txt

/bin/mail -s "Rkhunter daily report for $server" $mail < /tmp/rkhunter_report.txt
