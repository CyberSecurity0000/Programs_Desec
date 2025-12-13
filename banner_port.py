#!/usr/bin/python2

import sys, socket, os

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
       
       Port Scanner + Grabbing
       """

def usage():

    if len(sys.argv) != 2:

        apres()
        print "Usage: %s <ip>" % sys.argv[0]

    else:
        port_scanner(sys.argv[1])


def port_scanner(ip):
        
    banner_ports = [21, 22, 23, 25, 110, 143, 3306, 5432, 6379, 27017, 3389, 5900, 6667]

    try:
        for i in banner_ports:
        
            # Socket
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(0.5)

            if s.connect_ex((ip, i)) == 0:
            
                print "Porta %d: Aberta" %i
                banner = s.recv(1024)

                if banner:
                    print "Service: %s\n" % banner.strip() 

            s.close()

    except Exception as e:
        print "Erro inesperado !"


def main():
    apres()
    usage()

# Program
main()
