#!/bin/bash

added_keys=`ssh-add -l`

if  [[ ! $(echo $added_keys | grep -o -e soporte) ]]; then
    ssh-add "/home/jruiz/soporte/gongora/llaves/soporte"
fi

if [[ ! $(echo $added_keys | grep -o -e root) ]]; then
    ssh-add "/home/jruiz/soporte/gongora/llaves/root"
fi

if [[ ! $(echo $added_keys | grep -o -e spt_krono) ]]; then
    ssh-add "/home/jruiz/soporte/llaves/spt_krono"
fi
