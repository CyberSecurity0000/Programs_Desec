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
	echo "# Usage: $0 <host>"
else
	for i in $(host -t ns $1 | cut -d " " -f 4 | sed 's/.$//g')
	do
		cmd=$(host -l $1 $i 2>/dev/null)

		if [ $? -eq 0 ]
		then
			echo -e "\033[01;34m\nTransferência de zona -> IDENTIFICADA\033[00;00m"
			echo "$cmd"
		
		else
			echo -e "\033[01;31m\nTransferência de zona -> [X]\033[00;00m"
			echo "$i"
		fi
	done
fi
