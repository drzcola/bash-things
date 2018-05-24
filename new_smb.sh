#!/bin/bash

echo "Nombre de usuario: "
read user

echo "adduser --no-create-home --disabled-password --disabled-login $user"
echo "smbpasswd -a $user"

echo "Añadir usuario a grupos? (s/n)"
read option
while [ "$option" = "s" ]
do
    echo "Grupo: "
    read grupo    
    echo "usermod -a -G $grupo $user"
    echo "Usuario $user añadido a $grupo. Añadir a otro grupo? (s/n)"
    read option
done
echo "Usuario $user terminado."
