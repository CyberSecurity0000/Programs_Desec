#!/usr/bin/python2

import os, sys, socket

def apres():

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
       
       Subdomain: Host -> IP
       """


# Validacao + Execucao
def usage():

    if len(sys.argv) != 3:
        print "Usage: %s <domain> <wordlist>" % sys.argv[0]

    else:
        
        # Variaveis de controle
        cont = 0
        domain = sys.argv[1]
        wordlist = sys.argv[2]

        # Leitura de arquivos para pegar as linhas sem espaco
        with open(wordlist, "r") as file:

            linhas = file.read().split("\n")
            
            # Contagem de linhas do arquivo
            for i in linhas:
                cont += 1
            
            print "Arquivo com %s linhas\n" % cont

            # Testagem de Subdominios
            for i in linhas:
                
                # Concatenacao
                subdomain = ("%s.%s" % (i, domain))                
                ip = host(subdomain)

                # Validacao: Somente os IP retornam e excluissem os None
                if ip is not None:
                    print ("%s -> %s" % (subdomain, ip))

                #else:
                #    print "%s -> X" % subdomain


# Capturar IP do subdominio
def host(sub):

    try:
        ip = socket.gethostbyname(sub)

        if ip:
            return ip

    except Exception as e:
        #print e
        pass
    
    return


def main():
    apres()
    usage()


# Programa
main()
