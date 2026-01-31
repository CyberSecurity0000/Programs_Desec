#!/bin/bash

# Encerramento
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
       
       Parsing HTML + Host Resolver"
       echo -e "\033[00;00m"
}


# Mensagem
buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Hosts...          <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}


# Mensagem
resolvendo()
{
        echo -e "\033[01;33m"
        echo -e "##############################################"
        echo -e "|->          Resolvendo Hosts...           <-|"
        echo -e "##############################################"
        echo -e "\033[00;00m"
}


# Chama a função de apresentação
apres

# Verifica se foi passado exatamente 1 argumento
if [ $# -ne 1 ]
then
	echo -e "\n# Usage: $0 <domain>"

else
	# Baixa o HTML do domínio informado e salva como index.html
	wget $1 -q --no-verbose -O index.html 2>/dev/null

	# Renomeia o arquivo para <dominio>.html
	mv index.html $1.html 2>/dev/null

	# Mostra mensagem
	buscando

	# Extrai URLs do HTML
	# grep -Eo  = usa regex e mostra só o trecho encontrado
	# "(https?://[^ ]+).$1" = tenta capturar links contendo o domínio
	# cut -d "/" -f 3 = pega só o host
	# sort -u = remove duplicados
	cat $1.html 2>/dev/null | grep -Eo "(https?://[^ ]+).$1" | cut -d "/" -f 3 | sort -u > temp.txt

	# Mostra os hosts encontrados
	cat temp.txt 2>/dev/null

	# Mensagem de resolução DNS
	resolvendo

	# Lê cada host do arquivo temp.txt
	while read -r team
	do
		# Executa o comando host e pega a 4ª coluna (IP)
		cmd=$(host $team 2>/dev/null | awk '{print $4}')

		# Se não retornar nada, link sem IP resolvido
		if [ -z "$cmd" ]
		then
			echo "Links não encontrados !"
		else
			# Mostra host e IP com cores
			echo -e "\033[01;34m# Host -> $team\033[01;00m"
		       	echo -e "\033[01;35m# IP   -> $cmd\n\033[01;00m"
		fi
	
	done < temp.txt   # fonte de leitura do while
fi

# Apaga os arquivos temporários no final
rm $1.html 2>/dev/null
rm temp.txt 2>/dev/null
