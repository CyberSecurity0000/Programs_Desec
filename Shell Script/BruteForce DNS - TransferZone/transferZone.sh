#!/bin/bash

# Função de apresentação (banner e título)
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
       
       Zone Transfer"

        echo -e "\033[00;00m"
}

# Mensagem de início da busca
buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->  Buscando Transferencia de Zona ... <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

# Mostra o banner
apres


# Verificação de uso correto
# $# = quantidade de argumentos recebidos
if [ $# -ne 1 ]
then
	echo -e "\n# Usage: $0 <host>"          # exemplo: ./script.sh dominio.com

else
	# Lista os servidores DNS do domínio
	# host -t ns = consulta registros NS
	# cut pega a 4ª coluna (nome do servidor)
	# sed remove o ponto final do hostname
	for i in $(host -t ns $1 | cut -d " " -f 4 | sed 's/.$//g')
	do
		# Tenta fazer transferência de zona no servidor atual ($i)
		# -l = AXFR (transferência de zona)
		cmd=$(host -l $1 $i 2>/dev/null)

		# $? guarda o retorno do último comando
		# 0 = sucesso
		if [ $? -eq 0 ]
		then
			echo -e "\033[01;34m\nTransferência de zona -> IDENTIFICADA\033[00;00m"
			echo "$cmd"   # mostra o resultado da transferência
		
		else
			# Se falhar, informa que esse servidor não permitiu
			echo -e "\033[01;31m\nTransferência de zona -> [X]\033[00;00m"
			echo "$i"     # mostra qual servidor recusou
		fi
	done
fi
