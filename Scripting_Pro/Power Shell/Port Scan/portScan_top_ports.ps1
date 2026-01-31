# FORMA 4

# Limpa a tela
cls

# Menu inicial
Write-Output "#----- Scanning -----#"
Write-Output "[1] - Scanner de porta comuns"
Write-Output "[2] - Scanner de portas baixas"

# Lê a opção digitada pelo usuário e converte para inteiro
$esc = [int] (Read-Host "# Opc: ")

# Lê o IP alvo
$ip = Read-Host "# IP "

# Se o usuário escolheu a opção 1 → scan de portas mais comuns
if ($esc -eq 1)
{
    # Lista das portas mais comuns (top ports)
    $top_ports = 21,22,23,25,53,80,110,135,139,143,389,443,445,587,631,993,995,1433,1521,3306

    Write-Output "Top Ports.....loading....."

    # Loop de teste porta por porta
    foreach ($i in $top_ports)
    {
        # Testa conexão:
        # -InformationLevel Quiet → retorna só True/False
        # -WarningAction SilentlyContinue → ignora avisos
        $cmd = Test-NetConnection $ip -Port $i -InformationLevel Quiet -WarningAction SilentlyContinue
        
        # Se a porta estiver aberta → imprime
        if ($cmd)
        {
            echo ""   # Linha vazia só pra visual
            Write-Output "# Porta Aberta [o]: $i"
        } 
    }  
}

# Se a opção for 2 → scan de portas baixas (1..1024)
elseif ($esc -eq 2)
{
    # Gera automaticamente a lista de portas 1 até 1024
    $high_ports = $(1..1024)

    Write-Output "High Ports.....loading....."

    foreach ($i in $high_ports)
    {
        $cmd = Test-NetConnection $ip -Port $i -InformationLevel Quiet -WarningAction SilentlyContinue

        if ($cmd)
        {
            Write-Output "# Porta Aberta [o]: $i"
        }
    }
}

# Qualquer outra opção → inválido
else
{
    Write-Output "Inválido !"
}
