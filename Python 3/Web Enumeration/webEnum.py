#!/usr/bin/python3

import sys, os
import requests
from urllib.request import urlopen


# Banner
def apres():

    os.system("clear")

    print(r"""
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Brute Force - Enumeration Domain """)
    print("")


# Função que valida parâmetros recebidos
def usage():

    # O script precisa de 2 argumentos:
    # 1 — URL alvo
    # 2 — wordlist
    if len(sys.argv) != 3:
        print(f"# Usage: {sys.argv[0]} <url> <wordlist>")
    
    else:
        url = sys.argv[1]
        wor = sys.argv[2]
        
        # Testa se a página existe (responde)
        if teste_pagina(url) == 200:

            # Mostra cabeçalhos HTTP do servidor
            permissao = headers(url)
            
            # Se deu certo → começa enumeração
            if permissao:
                enumeration(url, wor)

            else:
                pass

        else:
            print("Página inexistente !")


# Verifica se a URL existe tentando obter o código HTTP
def teste_pagina(url):

    try:
        return urlopen(url).getcode()

    except Exception as e:
        print("Erro ao extrar página !")


# Mostra informações dos cabeçalhos HTTP da resposta
def headers(url):
    
    print("\n++++++++++++++++++++++++++")
    print("+ INFORMACAO DO SERVIDOR +")
    print("++++++++++++++++++++++++++\n")

    head = requests.get(url).headers
    
    print(f"{'=-='* 20}")
    print(f"URL => {url}")

    # Loop para exibir cada header
    for i, j in head.items():
    	print(f"{i} => {j}")

    print(f"{'=-='* 20}")
    
    return True


# Função que faz brute-force de diretórios/arquivos
def enumeration(url, wor):
    
    print("\n+++++++++++++++")
    print("+ ENUMERATION +")
    print("+++++++++++++++\n")
    
    try:
        # Abre a wordlist
        with open(wor, "r") as file:

            linhas = file.read().splitlines()

            # Para cada linha do arquivo
            for i in linhas:

                # Ignora linhas comentadas e caminhos absolutos
                if not i.startswith("#") and not i.startswith("/"):
                    
                    # Monta a URL completa
                    url_path = f"{url}/{i}"

                    # Envia request
                    url_path_code = requests.get(url_path, timeout=3).status_code

                    # Se resposta = OK → existe
                    if url_path_code == 200:
                        print(f"# Encontrado -> {url_path}")


    except KeyboardInterrupt as e:
        print("Programa encerrado !")

    except Exception as e:
        print(e)
        pass


# Função principal
def main():
    apres()
    usage()


# Programa
main()

