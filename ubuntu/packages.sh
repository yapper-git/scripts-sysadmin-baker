#!/bin/bash
# packages.sh
#
# Principaux changements par rapport au script initial : 
#   - Support d'une seule et unique version : Ubuntu 16.04
#   - Suppression de paquets inutiles
#   - Installation de GeoGebra 5 (au lieu de GeoGebra 4, nécessite dépôt externe)
#   - Installation de Google Earth (par la méthode présente sur doc.ubuntu-fr.org)
#   - N'installe pas certains paquets : idle-python, gutenprint, sane, unity-tweak-tool, oracle8-java-installer, gnote, cups-pdf etc.
#   - CarMEtal non fonctionnel donc non installé, Scratch (version 1.4) obsolète non installée


# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

# Suppression des paquets inutiles (éventuellement installés)
apt-get -y purge gnome-software unity-webapps-service
apt-get -y purge bluez blueman  # bluetooth
apt-get -y purge pidgin empathy transmission-gtk
apt-get -y purge abiword gnumeric thunderbird

# Vérification que le système est à jour
apt-get update
apt-get -y dist-upgrade

# Activation du dépôt partenaire (nécessaire pour flash par exemple)
add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
apt-get update

# Formats non-libres
apt-get -y install ubuntu-restricted-extras ubuntu-restricted-addons unrar libavcodec-extra
apt-get -y install libdvdread4 ; bash /usr/share/doc/libdvdread4/install-css.sh
echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | /usr/bin/debconf-set-selections | apt-get -y install ttf-mscorefonts-installer  #FIXME

# Paquets généraux
apt-get -y install language-pack-gnome-fr language-pack-gnome-fr-base
apt-get -y install hunspell-{fr,en-gb,de-de,es} aspell-{fr,en,de,es}
apt-get -y install default-jre icedtea-plugin

#[ Bureautique ]
apt-get -y install verbiste-gnome
apt-get -y install libreoffice libreoffice-gtk libreoffice-l10n-fr
apt-get -y install evince
apt-get -y install freeplane  # remplaçant de freemind
apt-get -y install scribus
apt-get -y install xournal
apt-get -y install googleearth-package ; make-googleearth-package --force ; dpkg -i googleearth*.deb ; apt-get -f install

#[ Internet ]
apt-get -y install adobe-flashplugin  # nécéssite l'activation du dépôt partenaire
apt-get -y install firefox firefox-locale-fr
apt-get -y install chromium-browser chromium-browser-l10n

#[ Audio / Vidéo ]
apt-get -y install x264 x265 flac lame vorbis-tools
apt-get -y install totem vlc
apt-get -y install gnome-sound-recorder audacity pavucontrol
apt-get -y install openshot pitivi

#[ Graphisme / Photo ]
apt-get -y install gimp gimp-help-fr pinta inkscape imagemagick
apt-get -y install blender
apt-get -y install sweethome3d sweethome3d-furniture sweethome3d-furniture-editor sweethome3d-furniture-nonfree

#[ Mathématiques ]
add-apt-repository "deb http://www.geogebra.net/linux/ stable main" ; apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C072A32983A736CF ; apt-get update ; apt-get -y install geogebra5
apt-get -y install algobox

#[ Jeux ]
apt-get -y install tuxmath
apt-get -y install gnome-mines gnome-sudoku
apt-get -y install sgt-puzzles

#[ Sciences ]
apt-get -y install avogadro
apt-get -y install stellarium

#[ Système ]
apt-get -y install vim

#[ Serveur ]
#apt-get -y install openssh-server  # utile pour ceux qui utilisent "Ansible"

# Nettoyage station 
apt-get -y autoremove --purge
apt-get -y clean

# Fin
echo "Le script de postinstall a terminé son travail"
read -p "Voulez-vous redémarrer immédiatement ? [O/n] " rep_reboot
if [ "$rep_reboot" = "O" ] || [ "$rep_reboot" = "o" ] || [ "$rep_reboot" = "" ] ; then
    reboot
fi
