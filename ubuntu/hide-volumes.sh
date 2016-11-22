#!/bin/bash

# http://askubuntu.com/questions/195988/how-can-i-remove-launcher-drive-icons
# http://unix.stackexchange.com/questions/27484/set-default-global-gnome-preferences-gnome-3

if [ "$UID" -ne "0" ] ; then
  echo "Il faut être root pour exécuter ce script. ==> sudo"
  exit 1
fi


echo "[com.canonical.Unity.devices]
blacklist=['UUID1', 'UUID2']
" > /usr/share/glib-2.0/schemas/my-defaults.gschema.override

glib-compile-schemas /usr/share/glib-2.0/schemas
