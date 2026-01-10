#!/bin/bash

# Controle
trap "exit 1" INT

# Função de apresentação com banner e cor
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
       
       PorScanner + TopPorts -> NetCat"

	echo -e "\033[00;00m"
}

# Função apenas para imprimir a “etapa de busca”
buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->          Buscando Portas..          <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

# Chamada da função de apresentação
apres

# --- INÍCIO DO PROGRAMA ---

# Verifica se foram passados exatamente 2 argumentos
# $1 = IP / Host
# $2 = arquivo com lista de portas
if [ $# -ne 2 ]
then
	echo -e "\n# Usage $0 <ip> <portas.txt>"

else
	buscando
	echo -e "Host -> $1\n"

	# Lê cada linha (porta) do arquivo informado
	for i in $(cat $2)
	do
		# Testa a porta com netcat (nc)
		# -v → verbose
		# -z → não envia dados, só testa conexão
		timeout 3s nc -vz $1 $i 2>/dev/null   # Joga erros para /dev/null pra não poluir a saída
		
		# Verifica o retorno do comando anterior
		if [ $? -eq 0 ]
		then
			# Status 0 = conexão OK → porta aberta
			echo -e "\033[01;36m# Porta $i: Aberta [o]\033[00;00m"
		fi
	done
fi

