// Ping Sweep

#include <stdio.h>    // Biblioteca padrão para printf(), etc.
#include <stdlib.h>   // Biblioteca para system() e outras funções do sistema

int main (int argc, char *argv[])
{
	// Variáveis	
        char *programa = argv[0];	// argv[0] = nome do programa
        char *ip = argv[1];		// argv[1] = IP base que o usuário passa (ex: 192.168.0)
        char cmd[256];			// Buffer para montar o comando do ping

        // Verifica se o usuário passou exatamente 1 argumento (o IP base)
        if (argc != 2)
        {
                // Orientação de uso caso falte algo
                printf("# Usage: %s <ip> (ex: 192.168.0)\n", programa);
        }

        else
        {
                // Loop de 1 a 10 -> fará 192.168.0.1 até .10
                for (int i = 1; i <= 254; i++)
                {
                        // Monta o comando ping, redirecionando saída para "/dev/null"
                        // -c 1 = 1 pacote
                        // -w 1 = timeout 1 segundo
                        snprintf(cmd, sizeof(cmd), "ping -c 1 -w 1 %s.%d 1>/dev/null 2>&1", ip, i);

                        // Executa o ping e captura o código de saída
                        int status = system(cmd);

                        // Se status == 0 -> o host respondeu (está online)
                        if (status == 0)
                        {
                                printf("# IP: %s.%d Online\n", ip, i);

                                // Garante que imprime imediatamente (output em tempo real)
                                fflush(stdout);
                        }
                }
        }

        // Final do programa
        return 0;
}
