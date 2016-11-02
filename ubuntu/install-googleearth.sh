#!/bin/bash
# install-googleearth.sh

# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

apt-get -y install googleearth-package
make-googleearth-package --force
dpkg -i googleearth*.deb
apt-get -y -f install
rm googleearth*.deb GoogleEarthLinux.bin
