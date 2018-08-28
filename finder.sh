#!/bin/bash

dir='/var/spool/asterisk/monitor'

# Busca todos las carpetas en el directorio $dir y envía el output al archivo /tmp/files.txt
find $dir -type f -name "*.wav" \( -mtime 1 -or -mtime 0 \) > /tmp/files.txt

# Recorre línea por línea el archivo /tmp/files.txt para ejecutar el comando
while read -r line
do
    filename=$(echo "$line" | cut -f 1 -d '.')
    lame -b 32 --resample 8 -a $line $filename.mp3
    mv $filename.wav $filename.cnv
done < /tmp/files.txt
