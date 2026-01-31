#!/usr/bin/python3

# Importa bibliotecas do sistema
import os, sys, socket


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
       
       Subdomain: Host -> IP """)
    print("\n")


# Função que valida os argumentos
def usage():

    # O script precisa de 2 argumentos: 1 → domínio |  2 → wordlist
    if len(sys.argv) != 3:
    	print(f"# Usage: {sys.argv[0]} <domain> <wordlist>")

    else:
        sub()   # Se estiver ok → chama a função principal


# Função responsável por montar subdomínios e resolver IP
def sub():
   
    dom = sys.argv[1]   # domínio alvo
    wor = sys.argv[2]   # wordlist

    # Abre a wordlist
    with open(wor, "r") as file:

        # Lê linha por linha
        arq = file.read().splitlines()
        
        print(f"# Testando...-> {dom}\n")

        # Para cada palavra → monta subdomínio
        for i in arq:
            
            sub= f"{i}.{dom}"
            ip = host(sub)   # tenta resolver IP

            # Se obteve IP → imprime
            if ip is not None:
                print(f"* {sub} -> {ip}")


# Função que consulta DNS
def host(sub):
    
    try:
        # Retorna o IP do subdomínio
        return socket.gethostbyname(sub)

    except Exception as e:
        return None   


# Função que organiza o fluxo do script
def main():
    apres()
    usage()


# Programa
main()
