#!/bin/bash

cliente='placeholder'
mail='placeholder@mail.com'

/usr/bin/mail "Informe $cliente `date`" $mail < /tmp/informe.csv
