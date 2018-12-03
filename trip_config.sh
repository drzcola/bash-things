#!/bin/bash

while read -r line
do
# Se usa | en lugar de / como separador en sed para evitar errores, 
# ya que la variable incluye tambien '/' al tratarse de una ruta.
    sed -i "s|$line|\#$line|g" twpol.txt
done < $1
