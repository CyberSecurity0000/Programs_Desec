#!/bin/bash

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
       
       Investigando Pessoas"

        echo -e "\033[00;00m\n"
}

info()
{
        echo -e "\033[01;32m"
        echo -e "###################################################"
        echo -e "|->   Buscando informações sobre $1 ...            "
	echo -e "###################################################"
        echo -e "\033[00;00m"
}


apres

if [ $# -eq 0 ]
then
	echo "Usage: $0 <nome>"
else

	info $1

	# Nome da pessoa (use aspas se tiver espaço)
	NOME=$(echo $* | sed 's/ /+/g')

	# PDFs — buscas gerais
	firefox "https://www.google.com.br/search?q=\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+ext:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\".pdf\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=inurl:pdf+\"$NOME\"" 2>/dev/null

	# PDFs — título, texto e URL
	firefox "https://www.google.com.br/search?q=intitle:\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=allintitle:\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=allintext:\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"relatorio\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"apresentacao\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"anexo\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"formulario\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"nota\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"informativo\"+filetype:pdf" 2>/dev/null

	# PDFs — por domínios genéricos públicos
	firefox "https://www.google.com.br/search?q=site:*.gov+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:*.edu+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:*.org+\"$NOME\"+filetype:pdf" 2>/dev/null

	# PDFs — serviços de nuvem
	firefox "https://www.google.com.br/search?q=site:drive.google.com+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:docs.google.com+\"$NOME\"+filetype:pdf" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:dropbox.com+\"$NOME\"+filetype:pdf" 2>/dev/null

	# TXT — buscas gerais
	firefox "https://www.google.com.br/search?q=\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+ext:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\".txt\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=inurl:txt+\"$NOME\"" 2>/dev/null

	# TXT — título e texto
	firefox "https://www.google.com.br/search?q=intitle:\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=allintext:\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"log\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"readme\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"documento\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=\"$NOME\"+\"nota\"+filetype:txt" 2>/dev/null

	# TXT — plataformas de código
	firefox "https://www.google.com.br/search?q=site:raw.githubusercontent.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:gist.github.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:github.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:gitlab.com+\"$NOME\"+filetype:txt" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:bitbucket.org+\"$NOME\"+filetype:txt" 2>/dev/null

fi
