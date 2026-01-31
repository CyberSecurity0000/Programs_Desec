#!/bin/bash

# Sai do script imediatamente se apertar CTRL+C
trap "exit 1" INT


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
       
       Brute Force DNS - SubDomain TakeOver"
       
       echo -e "\033[00;00m"
}


buscando()
{
        # Apenas efeito visual
        echo -e "\033[01;32m"
        echo -e "#######################################"
        echo -e "|->          Buscando Alias...      <-|"
        echo -e "#######################################"
        echo -e "\033[00;00m"
}

# Chama o banner
apres

# Verifica se foram passados 2 argumentos (domínio e wordlist)
if [ $# -ne 2 ]
then
	echo -e "\033[01;32mUsage: $0 <domain> <wordlist>\033[00;00m"

else
	# Chamada de metodo
	buscando

	# Lê a wordlist linha a linha
	while read -r team
	do
		# Monta o subdomínio → palavra.wordlist + domínio
		subdomain=$team.$1

		# Faz consulta DNS do tipo CNAME
		# host -t CNAME → pega alias
		# grep "alias" → filtra só linhas úteis
		# awk '{print $6}' → pega o campo do destino
		# sed 's/.$//g' → remove o ponto final
		cmd=$(host -t CNAME $subdomain 2>/dev/null| grep "alias" | awk '{print $6}' | sed 's/.$//g')

		# Se encontrou CNAME, exibe ("-n" = não pode ser vazia)
		if [ -n "$cmd" ]
		then
			echo -e "\033[01;30m# Alias encontrado:\033[00;00m"
			echo -e "\033[01;33m$subdomain\033[00;00m --> \033[01;34m$cmd\033[00;00m\n"
		fi

	# Wordlist vem aqui
	done < $2
fi
