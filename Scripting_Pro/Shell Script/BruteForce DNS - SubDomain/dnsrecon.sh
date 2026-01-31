#!/bin/bash

# Sai do script ao apertar CTRL+C
trap "exit 1" INT


# Função: exibe banner
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
       
       Brute Force DNS - Subdomain"
       
       echo -e "\033[00;00m"
}


# Função: print “buscando…”
buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando SubDomain...      <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}


# Chama o banner
apres

# Verifica se os argumentos foram passados
# $1 = domínio / $2 = wordlist
if [ $# -ne 2 ]
then
	echo -e "\nUsage: $0 <domain> <wordlist>"	

else
	# Chamada de metodo
	buscando

	# Lê a wordlist linha a linha
	while read -r team
	do
		# Resolve DNS do subdomínio
		# host → pesquisa DNS
		# 2>/dev/null → remove erros
		# grep -v "NXDOMAIN" → remove não-existentes
		# awk → mostra apenas host + IP
		
		#cmd=$(host "$team.$1" | grep -v "NXDOMAIN" | awk '{print $1,$4}')
		cmd=$(host "$team.$1" 2>/dev/null | grep -v "NXDOMAIN" | awk '{print $1,$4}')

		# Se encontrou IP, imprime
		if [ -n "$cmd" ]
		then
			echo -e "\033[01;33m# Host encontrado: \033[00;00m\033[01;34m$cmd\033[00;00m\n"
		fi

	# Redireciona a wordlist pra leitura
	done < $2
fi
