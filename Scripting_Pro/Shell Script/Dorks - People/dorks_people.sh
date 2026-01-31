#!/bin/bash

# Encerramento
trap "exit 1" INT


# Função que limpa a tela e mostra o banner
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
       
       OSINT -> Investigando Pessoas"

        echo -e "\033[00;00m"
}


# Função que exibe mensagem sobre o alvo pesquisado
info()
{
        echo -e "\033[01;32m"
        echo -e "###################################################"
        echo -e "|->   Buscando informações sobre $1 		    "
	echo -e "###################################################"
        echo -e "\033[00;00m"
}


# Chama a apresentação
apres

# Verifica se nenhum parâmetro foi passado
if [ $# -eq 0 ]
then
	# Orienta o uso correto
	echo "Usage: $0 <nome>"
else

	# Chamada de metodo com passagem de parametro
	info $1

	# Junta todos os argumentos em uma string e troca espaço por +
	NOME=$(echo $* | sed 's/ /+/g')

	# Pesquisas em PDF gerais
	firefox "https://www.google.com.br/search?q=\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+ext:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\".pdf\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=inurl:pdf+\"$NOME\"" 2>/dev/null

	# PDFs focando em título/texto
	firefox "https://www.google.com.br/search?q=intitle:\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=allintitle:\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=allintext:\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"relatorio\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"apresentacao\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"anexo\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"formulario\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"nota\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"informativo\"+filetype:pdf" 2>/dev/null

	# PDFs em domínios públicos
	firefox "https://www.google.com.br/search?q=site:*.gov+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:*.edu+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:*.org+\"$NOME\"+filetype:pdf" 2>/dev/null

	# PDFs em serviços de nuvem
	firefox "https://www.google.com.br/search?q=site:drive.google.com+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:docs.google.com+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:dropbox.com+\"$NOME\"+filetype:pdf" 2>/dev/null

	# TXT gerais
	firefox "https://www.google.com.br/search?q=\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+ext:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\".txt\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=inurl:txt+\"$NOME\"" 2>/dev/null

	# TXT focando em título/texto
	firefox "https://www.google.com.br/search?q=intitle:\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=allintext:\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"log\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"readme\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"documento\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"nota\"+filetype:txt" 2>/dev/null

	# TXT em plataformas de código
	firefox "https://www.google.com.br/search?q=site:raw.githubusercontent.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:gist.github.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:github.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:gitlab.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:bitbucket.org+\"$NOME\"+filetype:txt" 2>/dev/null

fi
