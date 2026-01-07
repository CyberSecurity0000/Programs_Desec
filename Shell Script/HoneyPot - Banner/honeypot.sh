#!/bin/bash

# Define um “gancho” para CTRL+C (SIGINT).
# Quando você apertar CTRL+C, o script sai com código 1.
trap "exit 1" INT

# Apenas imprime na tela uma mensagem informando a porta usada.
echo "# Abrindo conexao na porta 21"

# Loop infinito — o servidor só para com CTRL+C
while true
do
    # nc = netcat
    # -l  = modo listen (escutar conexões)
    # -v  = verbose (mostrar detalhes)
    # -p  = define a porta (21)
    #
    # '< banner.txt'  -> tudo que está no arquivo banner.txt será enviado para quem conectar
    #
    # '1>> 21.log' -> grava a saída normal no arquivo 21.log (acrescentando no final)
    # '2>> 21.log' -> grava os erros no mesmo log
    #
    # Ou seja: quem conectar na porta 21 vai ver o conteúdo do banner.txt e tudo que acontecer será logado.
    nc -lvp 21 < banner.txt 1>> 21.log 2>> 21.log

    # Depois de cada conexão, registra a data no log
    date 1>> 21.log
done

