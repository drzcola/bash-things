#!/bin/bash

echo -n 'Backup (ruta absoluta): '

# Leer ruta para el backup
read path

# Verificar si la ruta existe en el sistema
if [ -d "$path" ]; then
    echo $path existe
else
    echo $path no existe. Abortando.
fi
