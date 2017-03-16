#!/bin/bash

proxy_def_autourl="http://wpad.proxyamon.local/wpad.dat"
proxy_def_ip="172.16.0.1"
proxy_def_port="3128"
proxy_env_noproxy="localhost,127.0.0.0/8,172.16.0.0/16,192.168.0.0/16"

#Paramétrage des paramètres Proxy pour Gnome
#######################################################
echo "[org.gnome.system.proxy]
mode='auto'
autoconfig-url=$proxy_def_autourl" >> /usr/share/glib-2.0/schemas/my-defaults.gschema.override
glib-compile-schemas /usr/share/glib-2.0/schemas

#Paramétrage du Proxy pour le système
######################################################################
echo "http_proxy=http://$ip_proxy:$port_proxy/
https_proxy=http://$ip_proxy:$port_proxy/
ftp_proxy=http://$ip_proxy:$port_proxy/
no_proxy=\"$proxy_env_noproxy\"" >> /etc/environment

#Paramétrage du Proxy pour apt
######################################################################
echo "Acquire::http::proxy \"http://$ip_proxy:$port_proxy/\";
Acquire::https::proxy \"https://$ip_proxy:$port_proxy/\";
Acquire::ftp::proxy \"ftp://$ip_proxy:$port_proxy/\";" > /etc/apt/apt.conf.d/20proxy

#Permettre d'utiliser la commande add-apt-repository derrière un Proxy
######################################################################
echo "Defaults env_keep = https_proxy" >> /etc/sudoers
