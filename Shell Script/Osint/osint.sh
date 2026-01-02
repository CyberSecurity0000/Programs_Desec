#!/bin/bash

tela()
{
    	# Função que imprime a arte ASCII na tela
	echo "
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                         
	"
}

menu()
{
	clear         # Limpa a tela
	tela          # Chama a função para mostrar a arte
		
	echo "+ Obs: Remover ou retirar arquivos com nome 'index.html' da pasta ao executar o programa"
	echo -e "\033[01;32m\n-------------\033[00;00m"
	echo -e "\033[01;31m    OSINT    \033[00;00m"
	echo -e "\033[01;32m-------------\n\033[00;00m"
	echo -e "\033[01;31m[1] Descobrir IP do alvo \033[00;00m"
	echo -e "\033[01;32m[2] Descobrir CNPJ do alvo \033[00;00m"
	echo -e "\033[01;33m[3] Listar links externos do alvo \033[00;00m"
	echo -e "\033[01;34m[4] Listar e-mails do alvo \033[00;00m"
	echo -e "\033[01;35m[5] Saida \n\033[00;00m"
	echo -e -n "# Opc: "
	read opc    	
	
	# Seleciona a função conforme a opção digitada
	case $opc in  
	1)	descobrir_ip;;
	2)	descobrir_cnpj;;
	3)	links_externos;;
	4)	descobrir_email;;
	5) 	exit 0;;
	*)	echo "Opcao Invalida" ;;
	esac
}

descobrir_ip()
{
	clear
	echo -e "\033[01;32m----------\033[00;00m"
	echo -e "\033[01;31m    IP    \033[00;00m"
	echo -e "\033[01;32m----------\n\033[00;00m"		
	echo -n "# Host: "
	read host

    	# Executa comando host e extrai IPv4 usando regex
	cmd=$(host "$host" 2>/dev/null | grep -Eo "([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})")

	# Verifica se a variável está vazia
	if [ -z "$cmd" ]  	
	then
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;31m-> Nao encontrado ! $cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	else
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;34m$cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	fi
}

descobrir_cnpj()
{
	clear
	echo -e "\033[01;32m--------------\033[00;00m"
	echo -e "\033[01;31m     CNPJ     \033[00;00m"
	echo -e "\033[01;32m--------------\n\033[00;00m"		
	echo -n "# Host: "
	read host

	# Extrai CNPJ usando WHOIS
	cmd=$(whois "$host" 2>/dev/null | grep -Eo "([0-9]{2})\.([0-9]{3})\.([0-9]{3})/([0-9]{3})")
	
	if [ -z "$cmd" ]
	then
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;31m-> Nao encontrado ! $cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	else
        	# Extrai o nome do dono do domínio
		cmd2=$(whois "$host" 2>/dev/null | grep -w "owner:" | awk -F ":" '{print $2}' | sed 's/^ *//g')

		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;32m-> CNPJ: $cmd\033[00;00m"
		echo -e "\033[01;33m\n-> $cmd2\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	fi
}

links_externos()
{
	clear
	echo -e "\033[01;32m---------------\033[00;00m"
	echo -e "\033[01;31m     LINKS     \033[00;00m"
	echo -e "\033[01;32m---------------\n\033[00;00m"		
	echo -n "# Host: "
	read host

	# Baixa página com timeout de 5s
	wget -q $host --timeout=5 1>/dev/null 2>&1
	
	# Renomeia index.html para HOST.txt
	mv index.html $host.txt 2>/dev/null
	
	# Extrai links externos usando regex
	cmd=$(cat $host.txt 2>/dev/null | grep -Eo "(https?://[^ ]+)" | sort -u)
	
	if [ -z "$cmd" ]
	then
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;31m-> Nao encontrado ! $cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	else
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;34m$cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	fi

	# Apaga arquivo temporário
	rm -rf $host.txt  
}

descobrir_email()
{
	clear
	echo -e "\033[01;32m-------------\033[00;00m"
	echo -e "\033[01;31m    EMAIL    \033[00;00m"
	echo -e "\033[01;32m-------------\n\033[00;00m"		
	echo -n "# Host: "
	read host

	# Baixa página com timeout
	wget -q $host --timeout=5 1>/dev/null 2>&1
	mv index.html $host.txt 2>/dev/null

    	# Extrai e-mails usando regex
	cmd=$(cat $host.txt 2>/dev/null | grep -Eo "([a-zA-Z0-9._%+-]+)@([a-zA-Z0-9.-]+)\.([a-zA-Z]{2,})" | sort -u)

	if [ -z "$cmd" ]
	then
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;31m-> Nao encontrado ! $cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	else
		echo -e "\n----------------------------------------------------------------------------"
		echo -e "\033[01;34m$cmd\033[00;00m"
		echo "----------------------------------------------------------------------------"
		echo -e "\n<< PRESS ENTER >>"
		read
	fi
	
	# Remove arquivo temporário
	rm -rf $host.txt
}

# Loop infinito do menu
while true  
do
	menu
done
