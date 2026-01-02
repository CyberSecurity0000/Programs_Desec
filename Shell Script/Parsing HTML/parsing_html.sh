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
       
       Parsing HTML"

	echo -e "\033[00;00m"
}

buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Hosts...          <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

resolvendo()
{
        echo -e "\033[01;33m"
        echo -e "##############################################"
        echo -e "|->          Resolvendo  Hosts...          <-|"
        echo -e "##############################################"
        echo -e "\033[00;00m"
}

# Mensagem
apres

if [ $# -ne 1 ]
then
	echo "Usage: $0 <domain>"
else
	wget -q --no-verbose $1 2>/dev/null	
	mv index.html $1.html 2>/dev/null
	
	buscando
	cat $1.html 2>/dev/null| grep -Eo "(https?://[^ ]+).$1" | cut -d "/" -f 3 | sort -u > temp.txt
	cat temp.txt 2>/dev/null

	resolvendo
	for i in $(cat temp.txt)
	do
		cmd=$(host $i 2>/dev/null | awk '{print $4}')

		if [[ -z $cmd ]]
		then
			echo "Links não encontrados !"
		else
			echo -e "\033[01;34m# Host -> $i\033[01;00m"
		       	echo -e "\033[01;35m# IP   -> $cmd\n\033[01;00m"
		fi
	done
fi

# Controle de deleção
rm $1.html 2>/dev/null
rm temp.txt 2>/dev/null
