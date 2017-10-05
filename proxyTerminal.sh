#!/bin/bash
ipHead='168.176'
port='8080'
username=$LOGNAME
pass=$PASSPROXYUNAL

if [ -n "$PASSPROXYUNAL" ]
then
	if [[ 1 -eq $# ]] && [[ "n" == $1  ||  "0" == $1 ]]
	then 
		gsettings set org.gnome.system.proxy mode 'none' ;
		sudo echo "" |sudo tee /etc/apt/apt.conf
		echo " x Deshecha configuración de proxy"
	elif [[ 1 -eq $# ]]; then
		ipTale=$1
		# ipTale=''

		proxyConnection=$username':'$pass'@'$ipHead'.'$ipTale

		gsettings set org.gnome.system.proxy mode 'manual' ;
		gsettings set org.gnome.system.proxy.http host $proxyConnection;
		gsettings set org.gnome.system.proxy.http port $port;
		gsettings set org.gnome.system.proxy.https host $proxyConnection;
		gsettings set org.gnome.system.proxy.https port $port;
		gsettings set org.gnome.system.proxy.ftp host $proxyConnection;
		gsettings set org.gnome.system.proxy.ftp port $port;
		gsettings set org.gnome.system.proxy.socks host $proxyConnection;
		gsettings set org.gnome.system.proxy.socks port $port;
		gsettings set org.gnome.system.proxy ignore-hosts "['localhost', '127.0.0.0/8', '168.176.*.*', '0.0.0.0:3000', '0.0.0.0', '0.0.0.0/3000']" 

	
		l1='Acquire::http::proxy "http://'$proxyConnection':'$port'";'
		l2='Acquire::https::proxy "https://'$proxyConnection':'$port'";'
		l3='Acquire::socks::proxy "socks://'$proxyConnection':'$port'";'
		sudo echo ${l1}$'\n'${l2}$'\n'${l3} |sudo tee /etc/apt/apt.conf >/dev/null
		echo " Hecha configuración de proxy"
	else
		echo "Error, es requerido un parametro"
		exit
	fi
	sudo cut -d' ' -f1 /etc/apt/apt.conf
else
	echo "No se ha configurado contraseña en ~/.profile de la forma: export PASSPROXYUNAL='mypass' "
fi	