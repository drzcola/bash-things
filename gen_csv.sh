#!/bin/bash

pass='G0ng0$N3wV7'
db='asterisk'

mysql $db --password=$pass < /root/consulta.sql | sed 's/\t/,/g' > /tmp/informe.csv
