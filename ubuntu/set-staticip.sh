#!/bin/bash
# static-ip.sh

INTERFACE=$(ip addr | grep -m2 ": en" | cut -d : -f 2 | cut -c 2-)  # prefix "en" for ethernet
GATEWAY=172.16.0.1
BROADCAST=172.16.255.255

# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

echo "Interface:    $INTERFACE"
echo "Passerelle:   $GATEWAY"
echo "Broadcast:    $BROADCAST"

read -p "Adresse IP:   " -e -i "172.16." INPUT_IP_ADDRESS
IP_ADDRESS=$INPUT_IP_ADDRESS/16

read -p "Êtes-vous sûr de vouloir appliquer cette configuration ? [O/n] " INPUT
if [ "$INPUT" = "O" ] || [ "$INPUT" = "o" ] || [ "$INPUT" = "Y" ] || [ "$INPUT" = "y" ] || [ "$INPUT" = "" ] ; then
    ip link set dev $INTERFACE up
    ip add flush dev $INTERFACE
    ip addr add $IP_ADDRESS broadcast $BROADCAST dev $INTERFACE
    ip route add default via $GATEWAY dev $INTERFACE
    echo "Done."
else
    echo "End, nothing to do."
fi
