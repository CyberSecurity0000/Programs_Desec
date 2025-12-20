#!/bin/bash

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
       
       Reverse IP"

	echo -e "\033[00;00m"
}

buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Subdomain...      <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

apres


if [ $# -ne 1 ]
then
	echo "# Usage: $0 <ip>"
else
	cmd=$(host $1 2>/dev/null | grep "has" | awk '{print $4}')
	
	if [ -n "$cmd" ]
	then
		echo "# IP para teste -> $cmd"
		echo "$cmd" > ip.txt
	else
		exit
	fi

	buscando
	for i in $(seq 1 254)
	do
		ip=$(cat ip.txt | cut -d "." -f 1-3)
		cmd2=$(host $ip.$i 2>/dev/null | grep "$1" | cut -d " " -f 5 | sed 's/.$//g')
		
		if [ -n "$cmd2" ]
		then
			echo "$cmd2"
		fi
	done
fi
