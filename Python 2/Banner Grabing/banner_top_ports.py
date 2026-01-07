#!/usr/bin/python2
# -*- coding: utf-8 -*-

import sys, socket, os

# Função que limpa a tela e imprime o banner
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
       
       Port Scanner + Grabbing Top Ports\n
       """


# Função que valida o uso correto do script
def usage():

    # Se não tiver exatamente 2 argumentos (script + IP)
    if len(sys.argv) != 2:

        apres()
        print "Usage: %s <ip>" % sys.argv[0]   # exemplo: python2 scanner.py 192.168.0.1

    else:
        port_scanner(sys.argv[1])  # chama o scanner com o IP informado


# Função principal de varredura de portas
def port_scanner(ip):
        
    # Lista de portas comuns (top services)
    banner_ports = [21,22,23,25,69,80,110,143,443,465,587,993,995,135,139,
                    445,3389,5985,5986,1433,1521,3306,5432,6379,27017,9042,
                    8080,8000,8443,3128,53,111,123,161,389,636,873,2049,6667,
                    11211,5000,9000,9090,49152,49153,6000,6001]

    try:
        # Loop em cada porta da lista
        for i in banner_ports:
        
            # Cria o socket
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)  # timeout de 1 segundo para evitar travar

            # connect_ex retorna 0 se a porta estiver aberta
            if s.connect_ex((ip, i)) == 0:

                print "Porta %d: Aberta" % i
                
                try:
                    # tenta pegar o banner do serviço
                    banner = s.recv(1024)

                    if banner:
                        print "Service: %s\n" % banner.strip()  # mostra o banner limpinho

                except Exception as e:                
                    # Se não conseguir pegar banner
                    print "Service: Sem banner\n"


    except Exception as e:
        # erro genérico (ex: IP inválido)
        print "Erro inesperado !"


    finally:       
        # fecha o socket no final
        s.close()


# Função principal
def main():
    apres()   # mostra o banner
    usage()   # valida argumentos e chama scanner

# Program
main()

