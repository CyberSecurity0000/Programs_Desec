#!/usr/bin/python3

# Bilbiotecas
import socket, os, sys
from datetime import datetime
from threading import Thread

def apres():

    os.system("clear")
    print (r"""
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
        
       Port Scanner - Top Ports
           """)


def usage():

    if len(sys.argv) != 2:

        print(f"# Usage: {sys.argv[0]} <ip>")

    else:
        main()


def port_scan(porta):

    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.settimeout(10)

        if s.connect_ex((sys.argv[1], porta)) == 0:
        
            print(f"Porta Aberta: {porta}")
            s.close()

    except Exception as e:
        pass

    except KeyboardInterrupt as e:
        print("Programa interrompido !")


def operational():

    threads = []

    try:
        
        for porta in range(1, 65536):
            t = Thread(target=port_scan, args=(porta,))

            threads.append(t)
            t.start()

        for t in threads:
            t.join()

    except Exception as e:
        pass

    except KeyboardInterrupt as e:
        print("Programa interrompido !")


def main():

    apres()
    temp_ini = datetime.now()
    
    operational()
    temp_fim = datetime.now()
    
    print(f"Tempo: {temp_fim - temp_ini}")


# Programa
usage()
