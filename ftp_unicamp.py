#!/usr/bin/python2

# Bibliotecas
import sys, os, socket

# Constantes
# Dica -> Testar com FTP ftp.unicamp.br (177.220.121.28)
porta = 21

# Credenciais
username="anonymous"
password="anonymous"

# PROGRAMA
os.system("clear")
print "\tFTP -> Interagindo com Servicos\n"

if len(sys.argv) == 2:

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    
    if s.connect_ex((sys.argv[1], int(porta))) == 0:

        print "Servico FTP na porta %d: Ativado" % porta
        print "Banner: %s\n" % s.recv(1024).strip()
        
        # Login
        print "Enviando login ..."
        s.send("USER %s\r\n" % username)
        resp = s.recv(1024)
        
        if "login ok" in resp:
            print "Username %s bem sucedido !" % username
            login = True

        else:
            print "Username %s falhou !" % username
            login = False

        print ""

        print "Enviando senha ..." 
        s.send("PASS %s \r\n" % password)
        resp = s.recv(1024)

        if "530 Login incorrect." in resp:
            print "Senha incorreta !"
            senha = False
        
        else:
            print "Senha correta !"
            senha = True

        print ""

        print "Status de conexao"
        if login and senha:
            print "Conexao bem sucedida !"

        else:
            print "Conexao falhou !"

    else:
        print "Servico FTP pode estar em outra porta ou desativado !"

else:
    print "Usage: %s <ip>" % sys.argv[0]
