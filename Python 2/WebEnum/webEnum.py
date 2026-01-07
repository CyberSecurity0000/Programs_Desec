#!/usr/bin/python2
# -*- coding: utf-8 -*-

# Bibliotecas
import os, sys, requests, urllib


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
       
       Brute Force - Enumeration Domain\n
       """


# Valida os argumentos e controla o fluxo principal
def usage():
    
    # O script espera 2 parâmetros:
    # 1 -> URL base (ex: http://site.com)
    # 2 -> Wordlist com caminhos (ex: admin, login, uploads...)
    if len(sys.argv) != 3:
        print "Usage: %s <url> <wordlist>" % sys.argv[0]

    else:
        # Primeiro pega info do servidor
        code = info(sys.argv[1])

        # Só continua se o site responder 200 OK
        if code != 200:
            return
        
        else:
            brute_force(sys.argv[1], sys.argv[2], code)



# Coleta informações básicas do servidor
def info(url):

    print "++++++++++++++++++++++++++"
    print "+ INFORMACAO DO SERVIDOR +"
    print "++++++++++++++++++++++++++\n"
    
    code = 0

    try:
        # urllib.urlopen faz a requisição (modo simples)
        req = urllib.urlopen(url)
        code = req.getcode()

        # Se retornar HTTP 200, exibe dados do servidor
        if code == 200:
        
            print "URL: %s" % req.geturl()
            print req.info()   # Cabeçalhos HTTP (server, cookies, etc)

    except Exception as e:
        print "Informacoes inexistentes !"
        #print e
        
    except KeyboardInterrupt:
   	print "Programa interrompido !"

    return code


# Brute force de diretórios/caminhos
def brute_force(url, wordlist, code):

    print "\n+++++++++++++++"
    print "+ ENUMERATION +"
    print "+++++++++++++++\n"

    try:
        if code == 200:
            print "Loading...\n"

            # Abre a wordlist
            with open(wordlist, "r") as file:
                
                linhas = file.read().split("\n")
                
                for i in linhas:

                    # Ignora linhas comentadas com # na wordlist
                    if not i.startswith("#"):

                        # Monta nova URL → ex: site.com/admin
                        nova_url = ("%s/%s" % (url, i))

                        # Faz requisição HTTP
                        requisicao = requests.get(nova_url, timeout=3)

                        # Se a página existir → imprime
                        if requisicao.status_code == 200:
                            print "-> %s" % nova_url

                        # Caso contrário, ignora silenciosamente
                        # else:
                        #    print "Erro -> %s" % nova_url
       
    except Exception as e:
        print "Nao foi possivel realizar Brute force"
        #print e

    except KeyboardInterrupt:
        print "Programa interrompido !"


def main():
    apres()
    usage()


# Execução principal
main()
