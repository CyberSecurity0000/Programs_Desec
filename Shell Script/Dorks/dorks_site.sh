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
       
       Investigando Sites"

        echo -e "\033[00;00m\n"
}

info()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->   Buscando informações do site...   <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}


apres

if [ $# -eq 0 ]
then
	echo "Usage: $0 <busca>"
else

	info
	ALVO=$(echo $* | sed 's/ /+/g')

	firefox "https://www.google.com.br/search?q=site:\"pastebin.com\"+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:\"trello.com\"+\"$ALVO\"" 2>/dev/null
	firefox "https://www.google.com.br/search?q=site:\"$ALVO\"+\"index+of\"" 
	firefox "https://www.google.com.br/search?q=site:\"$ALVO\"+ext:php" 
	firefox "https://www.google.com.br/search?q=site:\"$ALVO\"+ext:txt" 
	firefox "https://www.google.com.br/search?q=site:\"$ALVO\"+ext:asp" 
	firefox "https://www.google.com.br/search?q=site:\"$ALVO\"+ext:pdf" 
	firefox "https://www.google.com.br/search?q=site:\"github.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"gitlab.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"bitbucket.org\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"docs.google.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"drive.google.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"sites.google.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"reddit.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"medium.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"notion.site\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"slack.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"microsoft.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"atlassian.net\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"zendesk.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"freshdesk.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"shopify.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"figma.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"calendar.google.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"eventbrite.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=site:\"meetup.com\"+\"$ALVO\"" 
	firefox "https://www.google.com.br/search?q=\"$ALVO\"+\"curriculum+vitae\"" 
	firefox "https://www.google.com.br/search?q=\"$ALVO\"+\"vaga+de+emprego\"" 
	firefox "https://www.google.com.br/search?q=\"$ALVO\"+\"pol%C3%ADtica+de+privacidade\"" 
	firefox "https://www.google.com.br/search?q=\"$ALVO\"+\"termos+de+uso\""
fi
