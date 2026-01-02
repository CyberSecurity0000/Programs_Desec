#!/bin/bash

trap "exit 1" INT

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
       
       Reverse IP"

	echo -e "\033[00;00m\n"
}

buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->         Analisando Arquivos...      <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

apres

# Proteção de argumentos: cria pasta 'documentos' se não existir
if [ ! -e "documentos" ]
then
	mkdir documentos
fi

if [ $# -ne 1 ]
then
	echo -e "\033[01;32m Usage: $0 <domain>"

else
	# Baixa a página fornecida como argumento ($1) e salva como index.html
	wget -q --no-verbose "$1" -O index.html 2>/dev/null

	# Extrai URLs de arquivos jpg, jpeg, pdf, txt e doc e salva em temp.txt
	cat index.html 2>/dev/null | grep -Eo "https?://[^ >\"]+\.(jpg|jpeg|pdf|txt|doc)" | sort -u >> documentos/temp.txt
	
	# Remove o arquivo temporário da página
	rm -rf index.html 2>/dev/null

	# Entra na pasta 'documentos'
	cd documentos

	# Loop que lê cada URL do temp.txt
	while read -r team
	do
		# Baixa o arquivo da URL
		timeout 3s wget -q --no-verbose "$team" 2>/dev/null

		if [ $? -eq 0 ]
		then
			echo "=================================================="
	
			# Extrai o nome do arquivo da URL e converte %20 para espaço
			nome=$(basename "$team")
			nome=$(echo "$nome" | sed 's/%20/ /g')
		
			# Mostra que o arquivo foi baixado e roda exiftool para metadados
			echo "Baixou -> $nome"
			exiftool "$nome"
		
			echo "=================================================="
		else
			echo -e "\n\033[01;34m###### Arquivo nao foi possivel ler ######\033[00;00m"
		fi
		

	done < temp.txt
fi

# Volta para a pasta original e limpa documentos
cd ../
rm -rf documentos 2>/dev/null
