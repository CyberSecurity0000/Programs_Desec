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
       
       Port Scanner + Grabbing Top Ports
       """

def usage():

    if len(sys.argv) != 2:

        apres()
        print "Usage: %s <ip>" % sys.argv[0]

    else:
        port_scanner(sys.argv[1])


def port_scanner(ip):
        
    banner_ports = [21,22,23,25,69,80,110,143,443,465,587,993,995,135,139,
                    445,3389,5985,5986,1433,1521,3306,5432,6379,27017,9042,
                    8080,8000,8443,3128,53,111,123,161,389,636,873,2049,6667,
                    11211,5000,9000,9090,49152,49153,6000,6001]

    try:
        for i in banner_ports:
        
            # Socket
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(1)

            if s.connect_ex((ip, i)) == 0:

                print "Porta %d: Aberta" % i
                
                try:
                    banner = s.recv(1024)

                    if banner:
                        print "Service: %s\n" % banner.strip()

                except Exception as e:
                    print "Service: Sem banner\n"

    except Exception as e:
        print "Erro inesperado !"

    finally:
        s.close()


def main():
    apres()
    usage()

# Program
main()
