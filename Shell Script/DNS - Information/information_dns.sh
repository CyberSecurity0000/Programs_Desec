#!/bin/bash

# Sai do script ao apertar CTRL+C
# INT = sinal de interrupção (CTRL+C)
trap "exit 1" INT

# Função: exibe banner bonito com cor vermelha
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
       
       DNS - Information Gathering"
       echo -e "\033[00;00m"
}

# Função: (opcional) print 'buscando'
# OBS: você criou mas ainda não usa — se quiser usar, é só chamar ela
buscando()
{
        echo -e "\033[01;32m"
        echo -e "#####################################"
        echo -e "|->  Information Gathering DNS... <-|"
        echo -e "#####################################"
        echo -e "\033[00;00m"
}

# Função principal: faz consultas DNS com o comando host
information()
{
	# Registro A → IPv4 principal do domínio
	echo -e "\n\033[01;30m# Consulta o registro A (IPv4 principal do domínio)\033[00;00m"
	host -t A $1

	# Registro AAAA → IPv6
	echo -e "\n\033[01;31m# Consulta o IPv6 (AAAA)\033[00;00m"
	host -t AAAA $1

	# MX → servidores de email
	echo -e "\n\033[01;32m# Consulta os servidores de e-mail (MX)\033[00;00m"
	host -t MX $1

	# NS → servidores DNS autoritativos
	echo -e "\n\033[01;33m# Servidores DNS autoritativos (NS)\033[00;00m"
	host -t NS $1

	# HINFO → info de hardware e sistema (quase ninguém usa hoje)
	echo -e "\n\033[01;34m# Consulta informações de hardware/SO (HINFO)\033[00;00m"
	host -t HINFO $1

	# TXT → registros SPF, DMARC e outros textos
	echo -e "\n\033[01;35m# Consulta registros TXT (SPF, DMARC, etc.)\033[00;00m"
	host -t TXT $1

	# SOA → Start Of Authority = servidor DNS mestre do domínio
	echo -e "\n\033[01;36m# Consulta o registro SOA (Start Of Authority) — DNS principal\033[00;00m"
	host -t SOA $1
}

# Mostra o banner
apres

# Verifica se o usuário passou 1 argumento
# $# = quantidade de argumentos passados
if [ $# -ne 1 ]
then
	# Se não passou domínio, mostra exemplo de uso
	echo -e "\033[01;34m\n# Usage: $0 <domain>\033[00;00m"

else
	# Se passou domínio, chama a função principal
	information $1
fi

