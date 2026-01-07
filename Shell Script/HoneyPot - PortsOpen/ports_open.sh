#!/bin/bash

clear
echo -e "\033[01;32m### Abrindo portas via netcat###\033[00;00m"

# Abre a porta 21 e roda em background (&)
nc -lvp 21 &
sleep 1   # espera 1 segundo

# Abre a porta 22
nc -lvp 22 &
sleep 2   # espera 2 segundos

# Abre a porta 23
nc -lvp 23 &
sleep 2

# Abre a porta 25
nc -lvp 25 &
sleep 2

# Mensagem de confirmação
echo "Portas Abertas"

# Mostra conexões abertas e processos que estão escutando (-l)
netstat -ntlp
