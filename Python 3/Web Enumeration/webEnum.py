#!/usr/bin/python3

import sys, os
import requests
from urllib.request import urlopen


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
       
       Brute Force Enumeration Domain """)
    print("")


def usage():

    if len(sys.argv) != 3:
        print(f"# Usage: {sys.argv[0]} <url> <wordlist>")
    
    else:
        url = sys.argv[1]
        wor = sys.argv[2]
        
        if teste_pagina(url) == 200:
            permissao = headers(url)
            
            if permissao:
                enumeration(url, wor)

            else:
                pass

        else:
            print("Página inexistente !")



def teste_pagina(url):

    try:
        return urlopen(url).getcode()

    except Exception as e:
        print("Erro ao extrar página !")



def headers(url):
    
    print("\n++++++++++++++++++++++++++")
    print("+ INFORMACAO DO SERVIDOR +")
    print("++++++++++++++++++++++++++\n")

    head = requests.get(url).headers
    
    print(f"{'=-='* 20}")
    print(f"URL => {url}")

    for i,j in head.items():
        print(f"{i} => {j}")

    print(f"{'=-='* 20}")
    
    return True


def enumeration(url, wor):
    
    print("\n+++++++++++++++")
    print("+ ENUMERATION +")
    print("+++++++++++++++\n")
    
    try:
        
        # Montagem de URL para teste
        with open(wor, "r") as file:

            linhas = file.read().splitlines()

            for i in linhas:

                if not i.startswith("#") and not i.startswith("/"):
                    
                    url_path = f"{url}/{i}"
                    url_path_code = requests.get(url_path, timeout=3).status_code

                    if url_path_code == 200:
                        print(f"# Encontrado -> {url_path}")


    except KeyboardInterrupt as e:
        print("Programa encerrado !")

    except Exception as e:
        print(e)
        pass

def main():
    apres()
    usage()


# Programa
main()
