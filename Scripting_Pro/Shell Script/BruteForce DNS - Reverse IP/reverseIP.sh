#!/bin/bash

# Encerramento (Se o usuário apertar CTRL+C, o script encerra com código 1)
trap "exit 1" INT


# Função de apresentação (banner na tela)
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

       Reverse IP - SubDomain"

	echo -e "\033[00;00m"
}


# Função que só imprime um cabeçalho “Buscando…”
buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Subdomain...      <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}


# Chama a função apresentação
apres

# Verifica se o usuário passou exatamente 3 argumentos
# Ex: ./script.sh 37.59.174.225 224 239
if [ $# -ne 3 ]
then
	echo -e "\n Usage: $0 <IP> <Range> (ex: 37.59.174.225 224 239)"

else
	# Valida se o range informado está entre 0 e 255 e se o início do range é menor ou igual ao fim
	if [[ "$2" -gt 255 || "$2" -lt 0 ]] || [[ "$3" -gt 255 || "$3" -lt 0 ]] || [[ "$2" -gt "$3" ]]
	then
		echo -e "\033[01;31m +--- Erro no range ---+ \033[00;00m"
		exit 1

	else
		echo -e "\n\033[01;33m# Testando IP -> $1\n\033[00;00m"
		
		# Pega apenas os 3 primeiros octetos do IP base (Ex: 37.59.174.225 -> vira 37.59.174)
		ip=$(echo "$1" | cut -d "." -f 1-3 2>/dev/null)
		
		# Faz um loop de IP's completando o último octeto (Ex: 37.59.174.224 até 37.59.174.239)
		for i in $(seq $2 $3)
		do
			# Executa o comando host para resolver DNS reverso
			# Remove ponto final, ignora linhas erradas, pega só o campo com o hostname
			cmd=$(host $ip.$i | sed 's/.$//g' | grep -v "ip-" | grep -v "not found" | awk '{print $5}' 2>/dev/null)

			# Verifica se a variável NÃO está vazia (-n)
			if [ -n "$cmd" ]
			then
				# Imprime host encontrado em azul
				echo -e "\033[01;34m# Host Encontrado: $cmd\033[00;00m"
			fi
		done
	fi
fi
