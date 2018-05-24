#!/bin/bash

MYSQLHOST='127.0.0.1'
MYSQLDB='asteriskcdr'
MYSQLUSER='root'
MYSQLPASS='sfid-rpsd'

#DATE=$(date +%Y-%m)

#FILE="/tmp/informe_$DATE.csv"
FILE="/tmp/informe_mensual.csv"

MYSQLOPTS="--user=${MYSQLUSER} --password=${MYSQLPASS} --host=${MYSQLHOST} ${MYSQLDB}"

mysql ${MYSQLOPTS} << EOFMYSQL
SELECT 'calldate','source','dest','extension','status','duration'
UNION ALL
SELECT calldate,src,REPLACE(dst,'s','Locucion'),accountcode,REPLACE(REPLACE(REPLACE(disposition,0,'NO CONTESTADA'),2,'OCUPADO'),8,'CONTESTADA'),duration
FROM cdr
WHERE MONTH(calldate) LIKE MONTH(CURDATE())
AND YEAR(calldate) LIKE YEAR(CURDATE())
INTO OUTFILE '$FILE'
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\r\n'
EOFMYSQL
