#!/bin/bash

PROXY_AUTO="http://wpad.proxyamon.local/wpad.dat"
PROXY_IP="172.16.0.1"
PROXY_PORT="3128"
PROXY_GNOME_NOPROXY="['localhost', '127.0.0.0/8', '172.16.0.0/12', '192.168.0.0/16']"
PROXY_ENV_NOPROXY="localhost,127.0.0.0/8,172.16.0.0/12,192.168.0.0/16"

# Run using sudo, of course
if [ "$UID" -ne "0" ]; then
    echo "Il faut être root pour éxecuter ce script. ==> sudo" 1>&2
    exit 1
fi

#Paramétrage des paramètres Proxy pour Gnome
#######################################################
echo "[org.gnome.system.proxy]
mode='manual'
use-same-proxy=true
ignore-hosts=$PROXY_GNOME_NOPROXY
[org.gnome.system.proxy.http]
host='$PROXY_IP'
port=$PROXY_PORT
[org.gnome.system.proxy.https]
host='$PROXY_IP'
port=$PROXY_PORT
" >> /usr/share/glib-2.0/schemas/my-defaults.gschema.override
glib-compile-schemas /usr/share/glib-2.0/schemas

#Paramétrage du Proxy pour le système
######################################################################
echo "http_proxy=http://$PROXY_IP:$PROXY_PORT/
https_proxy=http://$PROXY_IP:$PROXY_PORT/
ftp_proxy=http://$PROXY_IP:$PROXY_PORT/
no_proxy=\"$PROXY_ENV_NOPROXY\"" >> /etc/environment

#Paramétrage du Proxy pour apt
######################################################################
echo "Acquire::http::proxy \"http://$PROXY_IP:$PROXY_PORT/\";
Acquire::https::proxy \"https://$PROXY_IP:$PROXY_PORT/\";
Acquire::ftp::proxy \"ftp://$PROXY_IP:$PROXY_PORT/\";" > /etc/apt/apt.conf.d/20proxy

#Permettre d'utiliser la commande add-apt-repository derrière un Proxy
######################################################################
echo "Defaults env_keep = https_proxy" >> /etc/sudoers
