#!/usr/bin/python2

import os, sys, requests, urllib

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
       
       Brute Force Enumeration Domain
       """


def usage():
    
    if len(sys.argv) != 3:
        print "Usage: %s <url> <wordlist>" % sys.argv[0]

    else:
        code = info(sys.argv[1])

        if code != 200:
            return
        
        else:
            brute_force(sys.argv[1], sys.argv[2], code)



def info(url):

    print "++++++++++++++++++++++++++"
    print "+ INFORMACAO DO SERVIDOR +"
    print "++++++++++++++++++++++++++\n"
    
    # Controle
    code = 0

    try:
        req = urllib.urlopen(url)
        code = req.getcode()

        if code == 200:
        
            print "URL: %s" % req.geturl()
            print req.info()
            

    except Exception as e:
        print "Informacoes inexistentes !"
        #print e
        
    except KeyboardInterrupt:
   	print "Programa interrompido !"

    return code


def brute_force(url, wordlist, code):

    print "\n+++++++++++++++"
    print "+ ENUMERATION +"
    print "+++++++++++++++\n"

    try:
        if code == 200:
            print "Loading...\n"

            with open(wordlist, "r") as file:
                
                linhas = file.read().split("\n")
                
                for i in linhas:

                    if not i.startswith("#"):
                        nova_url = ("%s/%s" % (url, i))
                        requisicao = requests.get(nova_url, timeout=3)

                        if requisicao.status_code == 200:
                            print "-> %s" % nova_url

                        #else:
                        #    print "Erro -> %s" % nova_url
       
    except Exception as e:
        print "Nao foi possivel realizar Brute force"
        #print e

    except KeyboardInterrupt:
        print "Programa interrompido !"


def main():
    apres()
    usage()


# Programa
main()
