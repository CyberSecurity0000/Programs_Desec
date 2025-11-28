#!/bin/bash

portas="13 37 30000 3000"

for i in $portas
do
	hping3 -S $1 -p $i -c 1 2>/dev/null | grep -v "HPING"
	echo "Conectando $1 na porta $i"
done

wget -q $1:1337 2>/dev/null 1>&2 && cat index.html | grep -v "<" | sed "s/.$//g" && rm index.html
#curl -A "DiegoScanner/1.0" $1:1337
#printf "GET / HTTP/1.1\r\nHost: HOST-AQUI\r\nUser-Agent: UA-AQUI\r\nConnection: close\r\n\r\n" | nc $1 1337
#printf "GET / HTTP/1.1\r\nHost: 37.59.174.235\r\nUser-Agent: DiegoScanner/1.0\r\nConnection: close\r\n\r\n" | nc 37.59.174.235 1337

