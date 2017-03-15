#!/bin/bash
# install-scratch2.sh
#
# ATTENTION : Ce script est seulement fonctionnel pour Ubuntu 16.04 (64 bit !)
#
# Voir :
#   - http://programmingexplorer.weebly.com/blog/installing-scratch-2-on-ubuntu-linux-1404-64-bit
#   - http://www.noobslab.com/2015/05/adobeair-is-now-available-for-ubuntu.html
#   - https://github.com/dane-lyon/experimentation/blob/master/scratch2_test.sh

# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

# Download the Adobe Air and Scratch files
wget -O AdobeAIRInstaller.bin http://airdownload.adobe.com/air/lin/download/2.6/AdobeAIRInstaller.bin
wget -O Scratch.air https://scratch.mit.edu/scratchr2/static/sa/Scratch-454.air

# Install dependencies
apt-get -y install libxt6:i386 libnspr4-0d:i386 libgtk2.0-0:i386 libstdc++6:i386 libnss3-1d:i386 libnss-mdns:i386 libxml2:i386 libxslt1.1:i386 libcanberra-gtk-module:i386 gtk2-engines-murrine:i386 libgnome-keyring0:i386 libxaw7

# Link files
ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0
ln -sf /usr/lib/x86_64-linux-gnu/libgnome-keyring.so.0.2.0 /usr/lib/libgnome-keyring.so.0.2.0

# Make installer executable and run it
chmod +x AdobeAIRInstaller.bin
./AdobeAIRInstaller.bin

# Run Scratch installation
/opt/Adobe\ AIR/Versions/1.0/Adobe\ AIR\ Application\ Installer $(realpath Scratch.air)

# Remove installer files and unlink symbolic files
rm AdobeAIRInstaller.bin Scratch.air
rm /usr/lib/libgnome-keyring.so.0 /usr/lib/libgnome-keyring.so.0.2.0
