#!/bin/bash

# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

read -p "Nom de la machine : " -e -i "$HOSTNAME" INPUT_HOSTNAME

hostname $INPUT_HOSTNAME
echo $INPUT_HOSTNAME > /etc/hostname
sed -i "s/ghost/$INPUT_HOSTNAME/g" /etc/hosts
