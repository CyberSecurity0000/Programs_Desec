#!/bin/bash





if [ $# -ne 1 ]
then
	echo "# Usage: $0 <ip>"
else
	cmd=$(host $1 2>/dev/null | grep "has" | awk '{print $4}')
	
	if [ -n "$cmd" ]
	then
		echo "# IP para teste -> $cmd"
		echo "$cmd" > ip.txt
	else
		exit
	fi

	for i in $(seq 1 254)
	do
		ip=$(cat ip.txt | cut -d "." -f 1-3)
		cmd2=$(host $ip.$i 2>/dev/null | grep "$1" | cut -d " " -f 5)
		
		if [ -n "$cmd2" ]
		then
			echo "$cmd2"
		fi
	done
fi
