#!/usr/bin/python3

# Bibiotecas internas e externas
import os, socket, datetime         # Interna
from informacoes import menu_portas # Externa


# Banner
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


# Função para coletar as configurações do usuário
def configuracoes():
    
    # Pede o IP de destino
    alvo = input("\n# IP: ")
    print("")

    # Chama função externa que retorna a lista de portas
    portas = menu_portas()
    
    return alvo, portas


# Função principal de varredura de portas
def port_scan(alvo, portas):
    
    # Flag de controle: True = encontrou porta aberta
    aux = False

    # Marca o horário inicial
    temp_ini = datetime.datetime.now()
    
    print(f"\nExecutando Scanner em -> {alvo}")

    try:
        # Loop passando por cada porta escolhida
        for i in portas:

            # Cria um socket TCP
            s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

            # Timeout de 0.5 segundos
            s.settimeout(0.5)

            # connect_ex retorna 0 quando a porta está aberta
            if s.connect_ex((alvo, i)) == 0:

                print(f"# Porta {i} -> Aberta [o]")
                
                # Marca que encontrou porta aberta
                aux = True

                s.close()

        # Se nenhuma porta abriu → alerta
        if aux == False:
            print("[x] Nenhuma porta foi encontrada aberta !")
    
    # Interrupção manual
    except KeyboardInterrupt:
        print("\n\n<<< Programa Interrompido ! >>>")

    # Qualquer outro erro
    except Exception as e:
        print("Erro:",e)
    

    # Marca o horário final e mostra a duração
    temp_fim = datetime.datetime.now()
    print(f"\nTempo de execução: {temp_fim - temp_ini}")


# Função que organiza o fluxo do programa
def main():

    apres()                              # Mostra o banner
    alvo, portas = configuracoes()       # Coleta IP e portas
    apres()                              # Limpa e mostra o banner de novo
    port_scan(alvo, portas)              # Executa o scanner


# Início do programa
main()
