#!/bin/bash

# Função de apresentação (limpa a tela e mostra o banner)
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
       
       Investigando Sites"

        echo -e "\033[00;00m\n"
}

# Função visual só para exibir mensagem de status
info()
{
        echo -e "\033[01;32m"
        echo -e "#########################################################"
        echo -e "|->   Buscando informações do site $1 ...	   	  "
        echo -e "#########################################################"
        echo -e "\033[00;00m"
}

# Chama a tela de apresentação
apres

# Valida se o usuário passou argumento
if [ $# -eq 0 ]
then
	echo "Usage: $0 <nome>"   # Exibe ajuda
else

	info $1  # Mostra mensagem

	# Junta tudo que foi digitado e troca espaços por "+"
	ALVO=$(echo $* | sed 's/ /+/g')
	
	DORK1='"@gmail.com" filetype:pdf | filetype:xls | filetype:doc | filetype:docx site:*.br'
	DORK2='intext:"@gmail.com" OR intext:"@hotmail.com" OR intext:"@yahoo.com" filetype:xlsx'
	DORK3='"contato" OR "e-mail" OR "email" OR "@" intext:"@empresa.com.br" filetype:pdf'
	DORK4='intext:"email" OR intext:"e-mail" filetype:xls intitle:"planilha" OR intitle:"lista"'
	DORK5='site:*.gov.br intext:"@" -inurl:(login | signin | entrar)'
	DORK6='"index of" "mailing" OR "lista_email" OR "emails" OR "@"'
	DORK7='filetype:vcf OR filetype:csv intext:"@gmail.com" OR intext:"@outlook.com"'
	DORK8='intext:"@hotmail" OR intext:"@outlook" OR intext:"@live" intitle:"currículo" OR intitle:"resume" filetype:pdf'
	DORK9='"confidencial" OR "restrito" filetype:xls OR filetype:xlsx intext:"email" OR intext:"@"'
	DORK10='intext:"@facebook.com" OR intext:"@instagram.com" OR intext:"@empresa.com" site:*.org.br OR site:*.com.br'

	# As linhas abaixo abrem buscas no Firefox com dorks específicas
	firefox "https://www.google.com.br/search?q=$DORK1+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK2+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK3+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK4+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK5+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK6+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK7+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK8+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK9+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=$DORK10+\"$ALVO\"" 2>/dev/null
fi
