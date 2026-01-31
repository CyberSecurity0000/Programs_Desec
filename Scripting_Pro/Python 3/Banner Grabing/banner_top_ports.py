#!/usr/bin/python3

# Importa as bibliotecas do sistema, rede e comandos do SO
import sys, socket, os


# Banner
def apres():

    # Limpa a tela (Linux)
    os.system("clear")

    # Imprime o banner com texto em ASCII
    print(r"""
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Port Scanner + Grabbing Top Ports """)


# Função que verifica se o usuário passou o IP na linha de comando
def usage():
    
    # sys.argv guarda os argumentos do terminal
    # Exemplo: python script.py 192.168.0.10
    if len(sys.argv) != 2:
        print(f"\n\nUsage: {sys.argv[0]} <ip>")

    else:
        # Se tiver IP, chama o port_scanner
        port_scanner(sys.argv[1])


# Função principal do scanner
def port_scanner(ip):

    # Lista de portas comuns para tentar conectar
    banner_ports = [21,22,23,25,69,80,110,143,443,465,
    		    587,993,995,135,139,445,3389,5985,5986,1433,
    		    1521,3306,5432,6379,2121,2222,27017,9042,8080,8000,
    		    8443,3128,53,111,123,161,389,636,873,2049,
    		    6667,11211,5000,9000,9090,49152,49153,6000,6001
    		    ]

    # Mostra o IP que está sendo testado
    print(f"\nTestando IP -> {ip}\n")

    # Loop para testar cada porta
    for porta in banner_ports:

        try:
            # Cria um socket TCP
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

            # Define tempo máximo de espera (0.5s)
            s.settimeout(0.5)
            
            # Tenta conectar na porta
            # Retorno 0 = porta aberta
            if s.connect_ex((ip, porta)) == 0:

                print(f"# Porta {porta} -> Aberta")

                try:
                    # Tenta receber o banner do serviço
                    banner = s.recv(1024).decode()

                    # Se o serviço respondeu, imprime
                    if banner:
                        print(f"# Serviço: {banner}")

                # Se não houver banner, apenas informa
                except Exception:
                    print("# Serviço: <<Sem Banner>>\n")
                    s.close()
                
                # Se apertar CTRL + C dentro do bloco
                except KeyboardInterrupt:
                    print("Programa encerrado !")
                    exit(0)

        # CTRL + C geral
        except KeyboardInterrupt:
            print("Programa encerrado !")
            exit(0)

        # Qualquer erro inesperado
        except Exception:
            print("Erro inesperado !")


# Chama o banner
apres()

# Chama a função que valida argumentos e executa o scanner
usage()
