#!/bin/bash

# Encerra o script imediatamente ao apertar CTRL+C
trap "exit 1" INT


# Banner
apres()
{
	clear
	# Cor vermelha
	echo -e "\033[01;31m"
	
	# Banner
	echo "
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Lista de Portas e Serviços"
       
       # Reseta cor
       echo -e "\033[00;00m"
}


while true
do
	# Chamada de funcao
	apres
	
	echo -n -e "\n\n\033[01;32m# Porta: \033[00;00m"
	read srv
	
	resp=$(grep -v "^#" /etc/services | sed '1d' | grep -iw "$srv")
	
	# -z : Sem nada
	if [ -z "$resp" ]
	then
		echo -e "\n\033[01;34m# Não encontrado \n\033[00;00m"

	else
		echo -e "\033[01;31m\n"
		echo -e "\033[01;34m--------------------------------------------------------------------------------------------------------\033[00;00m"
		
		printf "%s\n" "$resp"
		echo -e "\033[01;34m--------------------------------------------------------------------------------------------------------\033[00;00m"
	fi

	read -p "<<<<    ENTER   >>>>"
done
