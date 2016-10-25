#!/bin/bash
# packages.sh
#
# Principaux changements par rapport au script initial : 
#   - Support d'une seule et unique version : Ubuntu 16.04
#   - Suppression de paquets inutiles
#   - N'installe pas certains paquets : idle-python, gutenprint, sane, unity-tweak-tool, oracle8-java-installer, gnote, cups-pdf etc.
#   - N'installe pas Google Earth (utiliser le fichier install-googleearth.sh pour l'installer)
#   - N'installe pas Scratch 1 (utiliser le fichier install-scratch2.sh pour avoir la version 2)
#   - Installation de GeoGebra 5 (au lieu de GeoGebra 4, nécessite l'ajout d'un dépôt externe)
#   - CarMEtal non fonctionnel donc non installé


# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

# Suppression des paquets inutiles (éventuellement installés)
apt-get -y purge gnome-software unity-webapps-service
apt-get -y purge bluez blueman  # bluetooth
apt-get -y purge abiword gnumeric thunderbird pidgin empathy transmission-gtk
apt-get -y autoremove --purge

# Vérification que le système est à jour
apt-get update
apt-get -y dist-upgrade

# Activation du dépôt partenaire (nécessaire pour flash par exemple)
add-apt-repository "deb http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
apt-get update

# Formats non-libres
apt-get -y install ttf-mscorefonts-installer  # requires user agreement, includes in ubuntu-restricted-extras
apt-get -y install adobe-flashplugin  # replaces flashplugin-installer old method, REQUIRES partner repository
apt-get -y install libdvd-pkg ; dpkg-reconfigure libdvd-pkg  # replaces libdvdread4 old method
apt-get -y install ubuntu-restricted-extras  # includes ubuntu-restricted-addons unrar libavcodec-extra and much more

# Paquets généraux
apt-get -y install default-jre icedtea-plugin
apt-get -y install language-pack-gnome-fr language-pack-gnome-fr-base
apt-get -y install hunspell-{fr,en-gb,de-de,es} aspell-{fr,en,de,es}

#[ Bureautique ]
apt-get -y install ttf-bitstream-vera ttf-dejavu
apt-get -y install fonts-crosextra-carlito fonts-crosextra-caladea  # add calibri and cambria support
apt-get -y install verbiste-gnome
apt-get -y install libreoffice libreoffice-gtk libreoffice-l10n-fr
apt-get -y install evince
apt-get -y install freeplane  # replaeces freemind
apt-get -y install scribus
apt-get -y install xournal

#[ Internet ]
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
add-apt-repository "deb http://www.geogebra.net/linux/ stable main" ; apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C072A32983A736CF ; apt-get update ; apt-get -y install geogebra5 ; rm /etc/apt/sources.list.d/geogebra.list
apt-get -y install algobox

#[ Sciences ]
apt-get -y install avogadro
apt-get -y install stellarium

#[ Jeux ]
apt-get -y install tuxmath
apt-get -y install gnome-mines gnome-sudoku
apt-get -y install sgt-puzzles

#[ Système ]
#apt-get -y install vim

#[ Serveur ]
#apt-get -y install openssh-server  # utile pour ceux qui utilisent "Ansible"

# Nettoyage station
apt-get -y autoremove --purge
apt-get -y clean
