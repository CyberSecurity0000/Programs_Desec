#!/usr/bin/python3

# Bibiotecas internas e externas
from informacoes import menu_portas
import os, socket, datetime


def apres():

    os.system("clear")
    print ("""
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

def configuracoes():
    
    alvo = input("\n# IP: ")
    print("")
    portas = menu_portas()

    return alvo, portas


def port_scan(alvo, portas):
    
    # Controle
    aux = False

    # Começo do scanner
    temp_ini = datetime.datetime.now()
    
    print(f"\nExecutando Scanner em -> {alvo}")

    try:
        
        for i in portas:

            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            s.settimeout(0.5)

            if s.connect_ex((alvo, i)) == 0:

                print(f"# Porta {i} -> Aberta [o]")
                aux = True
                s.close()

        if aux == False:
            print("[x] Nenhuma porta foi encontrada aberta !")
    
    except KeyboardInterrupt:
        print("\n\n<<< Programa Interrompido ! >>>")

    except Exception as e:
        print("Erro:",e)
    

    # Fim do scanner
    temp_fim = datetime.datetime.now()
    print(f"\nTempo de execução: {temp_fim - temp_ini}")


def main():

    apres()
    alvo, portas = configuracoes()
    apres()
    port_scan(alvo, portas)

main()
