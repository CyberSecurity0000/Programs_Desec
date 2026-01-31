// Resolver DNS

#include <stdio.h>     // printf, etc
#include <netdb.h>     // gethostbyname()
#include <arpa/inet.h> // inet_ntoa()

int main (int argc, char *argv[])
{
    // Testa se o usuário passou exatamente 1 argumento (o domínio)
    if (argc != 2)
    {
        printf("Usage: %s <domain>", argv[0]);
    }

    else
    {
        struct hostent *alvo; 		// estrutura que guarda infos do DNS
        alvo = gethostbyname(argv[1]);  // resolve o domínio

        // Se der erro (não resolveu DNS), retorna NULL
        if (alvo == NULL)
        {
            printf("Host inválido ou não encontrado!");
            return 0; // encerra
        }

        // Se deu certo: Converte o IP pra string e exibe
        printf("[OK] Host encontrado: IP: %s\n", inet_ntoa(*((struct in_addr *)alvo->h_addr)));
    }
    
    return 0;
}

