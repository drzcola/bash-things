#!/bin/bash

dir1="/home/recording/"
dir2="/media/usb1/recording/"

while read -r date
do
		diff <(ls -l $dir1$date | wc -l) <(ls -l $dir2$date | wc -l)

		if [ "$?" -eq 0 ]; then
				echo "Backup $date OK" >> $dir1backup.log
		else
				echo "Backup $date erroneo" >> $dir1backup.log
		fi
done < listado.txt
