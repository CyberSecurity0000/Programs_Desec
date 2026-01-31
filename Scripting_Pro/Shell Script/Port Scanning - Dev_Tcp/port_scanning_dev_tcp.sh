#!/bin/bash

# Controle
trap "exit 1" INT

# Lista das portas mais comuns para testar
portas=(20 21 22 23 25 53 67 68 69 80
       	110 111 123 135 137 138 139 143 161 162
       	179 389 443 445 465 514 515 520 523 548
       	554 587 631 636 989 990 993 995 1080 1194 
	1433 1434 1521 1723 2049 2082 2083 3306 3389 5060 
	5061 5432 5900 6379 8080 8443
	)

	
apres()
{
	clear
	echo -e "\033[01;31m"

	# Banner ASCII
	echo "
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       PorScanner + TopPorts -> /dev/tcp"

	echo -e "\033[00;00m\n"
}


buscando()
{
        # Cor verde
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Portas..          <-|"
        echo -e "###########################################"

        # Reseta cor
        echo -e "\033[00;00m"
}


# Chama a função de apresentação
apres


# Verifica se o usuário passou 1 argumento (host)
if [ $# -ne 1 ]
then
	echo -e "\n# Usage: $0 <host>"

else
	# Chamada de Método
	buscando

	# Mostra o host informado
	echo -e "\033[01;312m# Host -> $1\033[00;00m\n"

	# Loop para testar cada porta da lista
	for i in ${portas[@]}
	do
		# Teste de conexão usando /dev/tcp, se conseguir conectar, o comando retorna status "0"
		#timeout 1s bash -c ">/dev/tcp/$1/$i" 2>/dev/null
		timeout 1s bash -c ">/dev/tcp/$1/$i" 2>/dev/null

		# Verifica o retorno do comando anterior
		if [ $? -eq 0 ]
		then
			# Se a porta estiver aberta, imprime
			echo -e "\033[01;34m# Porta Aberta:\033[00;00m $i"
		fi
	done
fi
