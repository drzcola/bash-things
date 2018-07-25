#!/bin/bash

if [[ -z $1 ]]; then
    echo "Uso: ./busca_grabaciones.sh <listado.txt>"
	echo "El archivo .txt debe contener los números separados por líneas"
	exit 2
fi

file="$1"
echo -n "Directorio: "
read dir

while read -r line
do
    number="$line"
    find $dir -type f -name "*$number*"
done < "$file"
