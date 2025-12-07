// Socket

#include <stdio.h>	// printf()
#include <sys/socket.h>	// socket(), connect(), AF_INET, SOCK_STREAM
#include <arpa/inet.h>	// inet_addr(), htons(), struct sockaddr_in
#include <unistd.h>	// close()

int main (void)
{
	// Variaveis e struturas
	int meusocket;
	int conecta;
	struct sockaddr_in alvo; // Armazena IP e Porta de destino
	
	// Criando Socket: AF_INET = IPv4, SOCK_STREAM = TCP
	meusocket = socket(AF_INET, SOCK_STREAM, 0);

	/* Configuracoes do Alvo */

	// IPv4 + Porta
	alvo.sin_family = AF_INET;
	alvo.sin_family = htons(80);

	// Converter String para formato de rede + Armazenamento na 'Struct'
	alvo.sin_addr.s_addr = inet_addr("192.168.0.1");

	/* Conexao */
	conecta = connect(meusocket, (struct sockaddr *)&alvo, sizeof(alvo));

	if (conecta == 0)
	{
		printf("Porta Aberta \n");
	}

	else
	{
		printf("Porta Fechada \n");
	}

	close(meusocket);

	return 0;
}
