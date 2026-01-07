#!/bin/bash

# Interrompe o script com CTRL+C (SIGINT)
trap "exit 1" INT

# Tela inicial com banner
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
       
       Metadata"

	echo -e "\033[00;00m\n"
}

# Apenas exibe mensagem “processando”
buscando()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->         Analisando Arquivos...      <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

apres

# Garante que a pasta 'documentos' exista.
# (serve como área temporária para os downloads)
if [ ! -e "documentos" ]
then
	mkdir documentos
fi

# Verifica se exatamente 1 argumento foi passado (o domínio / URL)
if [ $# -ne 1 ]
then
	echo -e "\n\033[01;32m Usage: $0 <domain>"

else
	# Baixa o HTML da página informada e salva como index.html (modo silencioso)
	wget -q --no-verbose "$1" -O index.html 2>/dev/null

	# Filtra e extrai apenas URLs que terminam em:
	# jpg / jpeg / pdf / txt / doc
	# Remove duplicados e salva em documentos/temp.txt
	cat index.html 2>/dev/null | grep -Eo "https?://[^ >\"]+\.(jpg|jpeg|pdf|txt|doc)" | sort -u >> documentos/temp.txt

	# Remove o HTML baixado (já não precisamos mais dele)
	rm -rf index.html 2>/dev/null

	# Entra na pasta de trabalho
	cd documentos

	# Lê cada linha (URL) do arquivo temp.txt
	while read -r team
	do
		# Tenta baixar o arquivo com limite de 3 segundos
		timeout 3s wget -q --no-verbose "$team" 2>/dev/null

		# Verifica se o download deu certo (código de saída 0)
		if [ $? -eq 0 ]
		then
			echo -e"\n=================================================="
	
			# Extrai só o nome do arquivo da URL
			nome=$(basename "$team")

			# Converte %20 para espaço
			nome=$(echo "$nome" | sed 's/%20/ /g')
		
			# Mostra o nome do arquivo baixado
			echo "Baixou -> $nome"

			# Analisa metadados do arquivo com exiftool
			exiftool "$nome"
					
			echo "=================================================="
		else
			# Se falhou o download, exibe aviso
			echo -e "\n\033[01;34m###### Nao foi possivel baixar o arquivo ######\033[00;00m"
		fi
		
	done < temp.txt
fi

# Volta para o diretório anterior
cd ../

# Remove a pasta temporária (limpeza final)
rm -rf documentos 2>/dev/null
