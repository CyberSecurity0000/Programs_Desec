#!/bin/bash

clear

# Controle
rm $1.ip.txt 2>/null


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

if [[ $# == 1 ]]
then
	# Chamada
	buscando

	# Download da pagina inicial
	wget -q --no-verbose $1 2>/dev/null
	mv index.html $1.html
	
	# Filtro de subdomínios
	cat $1.html | grep "href=" | cut -d "/" -f 3 | grep "\." | cut -d "\"" -f 1 | cut -d "<" -f 1 | grep -v " " > domain.txt
	rm $1.html
	cat domain.txt

	# Metodo para resolver hosts e enviar para relatorio
	resolvendo
	for i in $(cat domain.txt)
	do
		host $i | grep "address" | grep -v "IPv6" | tee -a $1.ip.txt
	done
	
	echo -e "\033[01;31m\n[+] Concluido: Salvando os resultados em: $1.ip.txt"

	rm domain.txt

else
	echo "Usage: $1 <domain>"
fi
