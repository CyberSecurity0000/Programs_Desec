#!/bin/bash

# Função de apresentação — limpa a tela e mostra o banner em vermelho
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
       
       Leitura de Bytes"

        echo -e "\033[00;00m"
}

# Função visual de "processando leitura"
leitura()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->        Leitura de bytes...          <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

# Chama função de apresentação
apres

# Verifica se o script recebeu exatamente 1 argumento
if [ $# -ne 1 ]
then
        # Se não recebeu, mostra o uso correto e sai
        echo -e "\n# Usage: $0 <arquivo hexadecimal>"

else
        # Se recebeu argumento, exibe mensagem de leitura
        leitura

        # Para cada "token" (palavra) do arquivo hexadecimal passado
        for i in $(cat $1)
        do
                # Converte o valor para formato \xHEX e adiciona em tmp1.txt
                echo "\x$i" >> tmp1.txt
        done
        
        # Junta tudo em uma única linha e salva em tmp2.txt
        cat tmp1.txt | tr -d "\n" > tmp2.txt 2>/dev/null

        # Interpreta os \xHEX e imprime os bytes reais
        printf "$(cat tmp2.txt)"
fi

# Apaga arquivos temporários (silenciosamente)
rm tmp1.txt 2>/dev/null
rm tmp2.txt 2>/dev/null
