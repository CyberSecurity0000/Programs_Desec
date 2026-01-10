#!/bin/bash
# Define o interpretador bash para execução do script

# Encerra o script imediatamente ao apertar CTRL+C
# Evita execução incompleta ou travada
trap "exit 1" INT

apres()
{
	# Limpa a tela para melhor visualização
	clear

	# Ativa cor vermelha no terminal
	echo -e "\033[01;31m"
	
	# Banner ASCII para identificação da ferramenta
	echo "
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       WEB RECON" 
       
       # Reseta as cores do terminal para o padrão
       echo -e "\033[00;00m"
}

buscando_dir()
{
	# Cabeçalho visual para enumeração de diretórios
	echo -e "\n\033[01;32m---------------------------------------------------------------------------------------------------------------------\033[00;00m"
	echo -e "|-> Buscando por Diretorios "
	echo -e "\033[01;32m---------------------------------------------------------------------------------------------------------------------\033[00;00m"
}

buscando_arq()
{
	# Cabeçalho visual para enumeração de arquivos
	echo -e "\n\033[01;33m---------------------------------------------------------------------------------------------------------------------\033[00;00m"
	echo -e "|-> Buscando por Arquivos"
	echo -e "\033[01;33m---------------------------------------------------------------------------------------------------------------------\033[00;00m"
}

buscando_arq_dir()
{
	# Cabeçalho visual para enumeração mista
	echo -e "\033[01;34m---------------------------------------------------------------------------------------------------------------------\033[00;00m"
	echo -e "|-> Buscando por Diretorios e Arquivos"
	echo -e "\033[01;34m---------------------------------------------------------------------------------------------------------------------\033[00;00m"
}

tecnologia()
{
	# Coleta o header "Server" para identificar o webserver
	srv=$(curl --head -s -H "User-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Axiom/1.0" "$1" | grep "Server" | cut -d ":" -f 2)

	# Coleta o header "X-Powered-By" para identificar tecnologias
	tec=$(curl --head -s -H "User-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36 Axiom/1.0" "$1" | grep "X-Powered-By:" | cut -d ":" -f 2)

	# Verifica se o servidor foi identificado
	if [ -n "$srv" ]
	then
		echo -e "\n\033[01;36m# WebServer Identificado:$srv\033[00;00m"
	else
		echo -e "\n\033[01;33m# WebServer Identificado: Sem informacao\033[00;00m"
	fi

	# Verifica se alguma tecnologia foi identificada
	if [ -n "$tec" ]
	then
		echo -e "\n\033[01;36m# Tecnologias:$tec\033[00;00m"
	else
		echo -e "\n\033[01;33m# Tecnologias: Sem informacoes\033[00;00m"
	fi
}

listagem_diretorio()
{
	# Lê a wordlist linha por linha
	while read -r team
	do
		# Envia requisição HTTP e captura apenas o status code
		status_code=$(curl -w %{http_code} -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "$1/$team/" -o /dev/null)

		# Se o diretório existir (HTTP 200), exibe na tela
		if [ "$status_code" -eq 200 ]
		then
			echo -e "\033[01;32mDiretorio encontrado: \033[00;00m\033[01;33m$1/$team\033[00;00m"
		fi

	done < $2	
}

listagem_extensao()
{
	# Lê a wordlist e testa arquivos com extensão definida
	while read -r team
	do
		# Monta o nome do arquivo com extensão e verifica status HTTP
		status_code=$(curl -w %{http_code} -s -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36" "$1/$team.$4" -o /dev/null)

		# Se o arquivo existir (HTTP 200), exibe na tela
		if [ "$status_code" -eq 200 ]
		then
			echo -e "\033[01;32mArquivo $4 encontrado: \033[00;00m\033[01;33m$1/$team.$4\033[00;00m"
		fi

	done < $2	
}

# Exibe o banner inicial
apres

# Valida se os argumentos mínimos foram passados
if [ $# -eq 0 ] || [ $# -eq 1 ]
then
	# Mensagens de uso incorreto
	echo -e "\n\033[01;32m# Usage 1: $0 <url> <wordlist> <extensao>\033[00;00m"
	echo -e "\n\033[01;33m# Usage 2: $0 http://businesscorp.com.br wordlist.txt -t php\033[00;00m"

else
	# Controle de fluxo baseado no terceiro argumento
	case $3 in
	
	"")
		# Modo padrão: apenas diretórios
		buscando_arq
		tecnologia $1
		
		buscando_dir
		listagem_diretorio $1 $2;;
    
        "-t")
		# Modo completo: diretórios + arquivos por extensão
		buscando_arq_dir
		tecnologia $1 
	
		buscando_dir
		listagem_diretorio $1 $2

		buscando_arq
		listagem_extensao $1 $2 $3 $4;;
	esac
fi

