#!/bin/bash

echo "Abrindo portas via netcat"
nc -lvp 21&
sleep 1

nc -lvp 22&
sleep 2

nc -lvp 23&
sleep 2

nc -lvp 25&
sleep 2

echo "Portas Abertas"
netstat -ntlp
