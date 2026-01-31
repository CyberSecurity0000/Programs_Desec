/* Programa: Subdomínio */

// Bibliotecas
#include <stdio.h>     // Funções básicas: printf, fopen, fgets, etc.
#include <string.h>    // Funções de string: strcspn.
#include <netdb.h>     // gethostbyname para resolver DNS
#include <arpa/inet.h> // inet_ntoa para converter 'IP' para 'string'


int main(int argc, char *argv[])
{
	// Verifica se o usuário passou EXATAMENTE 2 argumentos além do programa
	// Exemplo correto: ./scanner wordlist.txt google.com
	if (argc != 3)
	{
		printf("Usage: %s <wordlist> <dominio>\n", argv[0]);
		return 1; // Saida com erro
    	}

	// Salva os argumentos em variáveis
	char linha[256]; 	 // Buffer para armazenar cada linha do arquivo
	char *arquivo = argv[1]; // Arquivo com subdomínios (subs.txt)
	char *dominio = argv[2]; // Domínio alvo      (ex: google.com)
	
	// Abre o arquivo no modo leitura
	FILE *fp = fopen(arquivo, "r");

	// Se não abriu, dá erro
	if (!fp)
	{
		printf("Erro ao abrir arquivo: %s\n", arquivo);
		return 1;
	}

	// Loop que lê uma linha por vez do arquivo
	while (fgets(linha, sizeof(linha), fp))
	{
		char full[512];
		
		// Remove o caractere '\n' do final da linha
		linha[strcspn(linha, "\n")] = 0;

		// Monta o subdomínio completo: sub + "." + dominio
		// Ex: "www" + "." + "google.com" -> "www.google.com"
        	snprintf(full, sizeof(full), "%s.%s", linha, dominio);

		// Resolve DNS usando gethostbyname
		struct hostent *alvo = gethostbyname(full);

		// Se NULL → não resolveu
		if (alvo == NULL)
		{
			continue;
       		}

		// Converte o IP retornado para string legível
        	char *ip = inet_ntoa(*(struct in_addr *)alvo->h_addr);

		// Imprime somente os que resolvem
        	printf("[OK] %s -> %s\n", full, ip);
	}

	// Fecha o arquivo após terminar
	fclose(fp);

	return 0; // Sucesso
}
