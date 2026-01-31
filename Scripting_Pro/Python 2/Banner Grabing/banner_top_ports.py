#!/usr/bin/python2
# -*- coding: utf-8 -*-

# Bibliotecas
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
       
       Port Scanner Top Ports + Banner Grabbing\n"""


# Função que valida o uso correto do script
def usage():

    # Se não tiver exatamente 2 argumentos (script + IP)
    if len(sys.argv) != 2:
    	apres()
        print "Usage: %s <ip>" % sys.argv[0]	# Exemplo: python2 scanner.py(1) 192.168.0.1(2)

    else:
        port_scanner(sys.argv[1])  # Chama o scanner com o IP informado


# Função principal de varredura de portas
def port_scanner(ip):

    # Lista de portas comuns (top services)
    ports = [21,22,23,25,69,80,110,143,443,465,587,993,995,135,139,
             445,3389,5985,5986,1433,1521,3306,5432,6379,27017,9042,
             8080,8000,8443,3128,53,111,123,161,389,636,873,2049,6667,
             11211,5000,9000,9090,49152,49153,6000,6001]

    try:
        # Loop em cada porta da lista
        for i in ports:

            # Cria o socket
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)  # timeout de 1 segundo para evitar travar

            # connect_ex retorna 0 se a porta estiver aberta
            if s.connect_ex((ip, i)) == 0:

                print "Porta %d: Aberta" % i

                try:
                    # Tenta pegar o banner do serviço
                    banner = s.recv(1024)

                    if banner:
                        print "Service: %s\n" % banner.strip()  # mostra o banner limpinho

                except Exception as e:
                	print "Service: Sem banner\n"	# Se não conseguir pegar banner

    except Exception as e:
        print "Erro inesperado !" # erro genérico (ex: IP inválido)

    finally:
        s.close() # fecha o socket no final


# Função principal
def main():
    apres()   # mostra o banner
    usage()   # valida argumentos e chama scanner

# Program
main()
