#!/usr/bin/python3

# Bibliotecas usadas
import socket, os, sys
from datetime import datetime
from threading import Thread


# Banner
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
        
       Port Scanner Threads - All Ports""")

    print("")


# Valida se o usuário passou os argumentos corretos
def usage():

    # Se não passou exatamente 1 argumento (o IP)
    if len(sys.argv) != 2:

        print(f"\n # Usage: {sys.argv[0]} <ip>")

    else:
        # Se passou certo → executa o programa principal
        main()


# Função que testa uma porta específica
def port_scan(porta):

    try:
        # Cria um socket TCP
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

        # Tempo máximo de espera para conexão
        s.settimeout(10)

        # connect_ex retorna 0 quando a porta está aberta
        if s.connect_ex((sys.argv[1], porta)) == 0:
        
            print(f"Porta Aberta: {porta}")
            s.close()

    # Ignora erros (DNS, rede, reset, etc.)
    except Exception as e:
        pass

    # CTRL + C individual dentro da thread
    except KeyboardInterrupt as e:
        print("Programa interrompido !")


# Função que cria e gerencia as threads do scanner
def operational():

    threads = []

    try:
        # Loop de 1 até 65535 (todas as portas TCP)
        for porta in range(1, 65536):

            # Cria uma thread para cada porta
            t = Thread(target=port_scan, args=(porta,))

            threads.append(t)

            # Inicia a thread
            t.start()

        # Espera todas as threads terminarem
        for t in threads:
            t.join()

    # Ignora qualquer erro inesperado
    except Exception as e:
        pass

    # Interrupção geral via CTRL + C
    except KeyboardInterrupt as e:
        print("Programa interrompido !")


# Função principal
def main():

    # Marca o horário inicial
    temp_ini = datetime.now()
    
    # Executa o scanner
    operational()

    # Marca o horário final
    temp_fim = datetime.now()

    # Calcula e mostra o tempo total
    print(f"Tempo: {temp_fim - temp_ini}")


# Mostra o banner
apres()

# Ponto de entrada do programa
usage()
