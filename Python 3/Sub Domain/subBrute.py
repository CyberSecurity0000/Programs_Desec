#!/usr/bin/python3

import os, sys, socket


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


def usage():

    if len(sys.argv) != 3:
        print(f"# Usage: {sys.argv[0]} <domain> <wordlist>")

    else:
        sub()


def sub():
   
    dom = sys.argv[1]
    wor = sys.argv[2]
    
    with open(sys.argv[2], "r") as file:

        arq = file.read().splitlines()
        
        print(f"# Testando... -> {dom}\n")
        for i in arq:
            
            sub= f"{i}.{dom}"
            ip = host(sub)

            if ip is not None:
                print(f"* {sub} -> {ip}")


def host(sub):
    
    try:
        return socket.gethostbyname(sub)

    except Exception as e:
        pass
    



def main():
    apres()
    usage()


# Programa
main()
