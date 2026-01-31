#!/bin/bash

# Encerrramento
trap "exit 1" INT


# Banner
apres()
{
	clear
	echo -e "\033[01;31m"
	echo "
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Ping Sweep + Subnet /24"
       echo -e "\033[00;00m\n"
}


buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Hosts...          <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}


ping_scan()
{
	echo -e "\033[01;32m########## PING SCAN ##########\033[00;00m"
	buscando
	
	ip_mnt=$(echo "$1" | cut -d "." -f 1-3)

	for i in $(seq 1 254)
	do
		ping -c 1 -w 1 $ip_mnt.$i | grep "64 bytes" | cut -d " " -f 4 | sed 's/.$//g'
	done
}


fping_scan()
{
	echo -e "\033[01;33m########## FPING SCAN ##########\033[00;00m"
	buscando
	
	fping -a -q -g $1/24 >> temp.txt 2>/dev/null
	cat temp.txt | sort -u
	rm -rf temp.txt 2>/dev/null
}

arp_scan()
{
	echo -e "\033[01;34m########## ARP SCAN ##########\033[00;00m"
	echo -e "\033[01;31m+ Redes Internas \033[00;00m"
	buscando

	ip_mnt=$(echo "$1" | cut -d "." -f 1-3)
	
	arp-scan $ip_mnt.0/24 --numeric --quiet | grep -Eo "([0-9]){1,3}\.([0-9]){1,3}\.([0-9]){1,3}\.([0-9]){1,3}" | sort | grep "^$ip_mnt"
}


arping_scan()
{
	echo -e "\033[01;35m########## ARPING SCAN ##########\033[00;00m"
	echo -e "\033[01;31m+ Redes Internas \033[00;00m"
	buscando

	ip_mnt=$(echo "$1" | cut -d "." -f 1-3)
		
	for i in $(seq 1 254)
	do
		arping -c 1 $ip_mnt.$i -i $3 | grep -E "60 bytes|42 bytes" | grep -Eo "([0-9]){1,3}\.([0-9]){1,3}\.([0-9]){1,3}\.([0-9]){1,3}" | sort 
	done
}


manual()
{
	echo -e "+ Usage: $0 <ip> <opc1> <opc2>\n"
	
	echo -e "\033[01;32m-p Ping Scan (slow) \033[00;00m"
	echo -e "Ex: $0 192.168.0.1 -p \n"
	
	echo -e "\033[01;33m-f Fping Scan (fast) \033[00;00m"
	echo -e "Ex: $0 192.168.0.1 -f \n"

	echo -e "\033[01;34m-as Arp Scan (Super fast) \033[00;00m"
	echo -e "Ex: $0 192.168.0.1 -as \n"

	echo -e "\033[01;35m-ap Arping Scan <interface> (slow) \033[00;00m"
	echo -e "Ex: $0 192.168.0.1 -ap wlan0 \n"
}


# Mensagem
apres

if [ $# -le 1 ]
then
	manual

elif [ $# -eq 2 ] || [ $# -eq 3 ]
then
	if [ "$2" == "-p" ]
	then
		ping_scan $1

	elif [ "$2" == "-f" ]
	then
		fping_scan $1
	
	elif [ "$2" == "-as" ]
	then
		arp_scan $1
	
	elif [ "$2" == "-ap" ]
	then
		arping_scan $1 $2 $3
	fi
fi
