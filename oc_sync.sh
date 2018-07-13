#!/bin/bash

# Variables
ocdir=/var/www/owncloud
userdir=/var/owncloud/data
echo "Introduce el nombre de usuario [fullscan para escanear todos]: "
read user

# Modificación de permisos para ejecución
#chmod root:root $ocdir/config/config.php

# Escaneo de los directorios indicados
if [ "$user" == "fullscan" ]; then
    /usr/bin/php $ocdir/occ files:scan --all
else
    /usr/bin/php $ocdir/occ files:scan --path $user/files
fi
