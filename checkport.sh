#!/bin/bash

dir='/home/jruiz/soporte/gongora/puertos.txt'

/usr/bin/cat $dir | grep -i $1
