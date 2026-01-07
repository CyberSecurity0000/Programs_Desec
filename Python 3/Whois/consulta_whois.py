#!/usr/bin/python3

# Bibliotecas usadas
import sys, socket, os

# Apresentação
def apres():

    # Limpa a tela (Linux)
    os.system("clear")

    # Banner em ASCII + título
    print(r"""
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Consulta - Whois""")
    print("\n")



def usage():

    # Verifica se passou 1 argumento (o domínio)
    if len(sys.argv) != 2:
        print(f"# Usage: {sys.argv[0]} <domain>")

    else:
        # Pega o domínio do argumento
        domain = sys.argv[1]

        # Descobre qual servidor WHOIS é responsável
        referencia = refer(domain)

        # Arte
        print(f"{'=-='* 5} {domain} {'=-=' * 5} \n")

        # Se encontrou o servidor WHOIS
        if referencia:
            whois(referencia, domain)

        else:
            exit



def refer(domain):

    # Cria o socket TCP
    s = tomada()
    
    try:
        # Conecta ao servidor WHOIS global da IANA na porta 43
        if s.connect_ex(("whois.iana.org", 43)) == 0:

            # Envia o domínio com \r\n (padrão WHOIS)
            s.send(f"{domain}\r\n".encode())

            # Recebe até 1024 bytes e ignora erros de encoding
            # Depois divide o texto em palavras -> Lista
            resp = s.recv(1024).decode(errors="ignore").split()
        
            # Percorre a resposta procurando a linha "refer:"
            for i in range(0, len(resp)):

                if "refer:" in resp[i]:
                    s.close()
               
                    # Retorna o servidor WHOIS que cuida do domínio
                    return resp[i+1]

    except Exception as e:
        print(e)
    
    # Se algo deu errado ou não encontrou nada
    s.close()
    return None


# Função principal para a pesquisa
def whois(referencia, domain):

    # Criação de Socket
    s = tomada()

    try:
        # Conecta no servidor WHOIS que a IANA informou
        if s.connect_ex((referencia, 43)) == 0:

            # Envia o domínio
            s.send(f"{domain}\r\n".encode())

            # Recebe resposta e quebra em linhas
            resp = s.recv(1024).decode(errors="ignore").splitlines()

            # Mostra linha por linha
            for i in resp:
                print(i)

    except Exception as e:
        print(e)

    s.close()



def tomada():

    # Cria um socket TCP IPv4
    return socket.socket(socket.AF_INET, socket.SOCK_STREAM)



def main():
    apres()   # Mostra o banner
    usage()   # Processa argumentos e executa



# Inicia o programa
main()
