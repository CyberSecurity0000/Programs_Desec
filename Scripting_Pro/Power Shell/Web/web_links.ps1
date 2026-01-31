# FORMA 2

# Recebe um parâmetro: IP ou domínio
param($ip)

# Se o usuário NÃO informou o IP/domínio OU
# Se o usuário digitou QUALQUER COISA A MAIS depois do IP (ou seja: sobrou argumento em $args, e isso é erro)
# "0" é a contagem das sobras, não o valor passado.
if (!$ip -or $args.Count -gt 0)
{
	Write-Output "Usage: .\script.ps1 <domain>"
	#echo $args.Count
}

else
{
    # Limpa a tela
    cls  
    Write-Output "Forensics Web $ip..."
    
    # Faz requisição HTTP GET normal
    $web = Invoke-WebRequest -Uri "$ip"
    
    # Faz requisição HTTP OPTIONS para ver métodos permitidos
    $web2 = Invoke-WebRequest -Uri "$ip" -Method Options

    # Pega o header 'Server' do site (tipo Apache, nginx, etc)
    $server = $web.Headers.Server
    
    # Salva o conteúdo da página em arquivo index.txt
    $page = $web.Content > index.txt
    
    # Pega o status HTTP (200, 404, etc)
    $code = $web.StatusCode
    
    # Lista todos os links da página que começam com http
    $links_http = $web.Links.href | Select-String "http"
    
    # Lista todos os links da página que começam com https
    $links_https = $web.Links.href | Select-String "https"
    
    # Pega os métodos permitidos do servidor (OPTIONS)
    $opt = $web2.Headers.Allow
        
    Write-Output ""
    Write-Output "---- Report ----"
    Write-Output "Servidor: $server"
    Write-Output "Status: $code"
    Write-Output "Pagina index.html salva em index.txt "
    Write-Output "Options: $opt"

    Write-Output ""
    Write-Output "*** Links***"
    $links_http
    $links_https
}
