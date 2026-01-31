# FORMA 03 - Ping Sweep

# Recebe o IP base (ex: 192.168.0)
param($ip)

# Se nada for passado, mostra uso correto
if (!$ip)
{
    Write-Output "Usage: .\script.ps1 <host rede ex: 192.168.0>"
}

else
{
    # Loop varrendo toda a faixa /24 (1..255)
    foreach ($i in 1..255)
    {
        try
        {
            # Executa 1 ping e procura pela string "bytes=32"
            # Se achar, Select-String guarda a linha onde isso aparece
            $cmd1 = ping -n 1 -i 1 "$ip.$i" | Select-String "bytes=32"

            # Extrai somente o endereço IP da resposta:
            #   - .Line pega a linha toda do ping
            #   - Split(':')[0] pega antes dos dois-pontos
            #   - Split(' ')[2] pega o terceiro campo (o IP)
            $cmd2 = $cmd1.Line.Split(':')[0].Split(' ')[2]
        
            # Mostra IP encontrado online
            Write-Output "# IP: $cmd2 <<ONLINE>>"

            # Salva no arquivo ip.txt (modo append >>)
            $cmd2 >> ip.txt
        }

        catch
        {
            # Se o Select-String não achar nada, cai aqui.
            # Ping offline => simplesmente ignora.
        }
    }
}
