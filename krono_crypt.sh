#!/bin/sh

files="a1324250cf73bd6d3434f43d3dd7ad7c"
key=`echo "GR-LR-JM" | md5sum | cut -d" " -f1`

mb=`dmidecode -s system-serial-number`


totalaux=`echo $files$mb$key`
totalcif=`echo $totalaux | md5sum | cut -d' ' -f1`

echo $totalcif | /sbin/cryptsetup luksOpen /dev/mapper/centos-kronotek  kron
/bin/mount -t ext4 /dev/mapper/kron /mnt/krono
