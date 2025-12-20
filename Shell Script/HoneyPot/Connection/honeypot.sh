#!/bin/bash

echo "# Abrindo conexao na porta 21"

while true
do
	nc -lvp 21 < banner.txt 1>> 21.log 2>>21.log
	date 1>> 21.log
done
