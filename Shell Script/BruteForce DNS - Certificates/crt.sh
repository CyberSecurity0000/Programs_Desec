#!/bin/bash

# Encerra o script imediatamente ao apertar CTRL+C
trap "exit 1" INT

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
       
       Brute Force DNS - Digital Certificates" 
       
       # Reseta cor
       echo -e "\033[00;00m"
}

buscando()
{
        # Verde para destaque
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando SubDomain...      <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

# Exibe a apresentação
apres

# Verifica se foi passado 1 argumento (o domínio)
if [ $# -ne 1 ]
then
	echo -e "\n\033[01;34m# Usage: $0 <domain>\033[00;00m"

else
	buscando
	
	# Consulta o site crt.sh (base pública de certificados SSL)
	# --silent -> não mostra progresso
	# grep/regex -> filtra só os domínios
	cmd=$(curl --silent "https://crt.sh/?q=$1" 2>/dev/null | grep "<TD>" | grep "<BR>" | sort -u | grep -Eo "([0-9a-zA-Z]+).$1" | grep -v ">" | sort -u)

	# -z -> verifica se a variável está vazia (tem que estar "Zem nada")
	if [ -z "$cmd" ]
	then
		echo -e "\033[05;33m# Nao encontrado nenhum subdominio, tente novamente mais tarde !\033[00;00m"
	else
		echo "$cmd"
	fi
fi
