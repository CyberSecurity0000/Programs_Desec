#!/usr/bin/python2
# -*- coding: utf-8 -*-

# Bibliotecas
import os, sys, socket


# Banner
def apres():

    # Limpa a tela do terminal
    os.system("clear")

    print """
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Subdomain: Host -> IP\n"""


# Validação dos argumentos + Execução do programa
def usage():

    # O script exige 2 parâmetros:
    # 1 -> domínio principal (ex: google.com)
    # 2 -> wordlist com possíveis subdomínios (ex: www, mail, vpn etc)
    if len(sys.argv) != 3:
        print "Usage: %s <domain> <wordlist>" % sys.argv[0]

    else:
        # Variáveis de controle
        cont = 0
        domain = sys.argv[1]
        wordlist = sys.argv[2]

        # Abre a wordlist e lê tudo, separando linha por linha
        with open(wordlist, "r") as file:

            linhas = file.read().split("\n")

            # Conta quantas linhas existem na wordlist
            for i in linhas:
                cont += 1

            print "Arquivo com %s linhas\n" % cont

            # Para cada linha, monta um subdomínio e testa
            for i in linhas:

                # Monta algo tipo: www.google.com
                subdomain = ("%s.%s" % (i, domain))

                # Tenta resolver o IP desse subdomínio
                ip = host(subdomain)

                # Se conseguir resolver → imprime
                if ip is not None:
                    print ("%s -> %s" % (subdomain, ip))


# Função que tenta descobrir o IP de um subdomínio
def host(sub):

    try:
        # Faz a consulta DNS (resolve o nome para IP)
        ip = socket.gethostbyname(sub)

        # Se existir IP, retorna
        if ip:
            return ip

    except Exception as e:
        # Qualquer erro (subdomínio inexistente etc) é ignorado
        pass
    
    # Se não conseguir resolver, retorna vazio
    return


# Programa operacional
def main():
    apres()
    usage()

# Execução principal do programa
main()
