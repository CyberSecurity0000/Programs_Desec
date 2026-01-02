#!/bin/bash

apres()
{
        clear
        echo -e "\033[01;31m"
        echo "
  _____      _               _____                      _ _          ___   ___   ___   ___  
 / ____|    | |             / ____|                    (_) |        / _ \ / _ \ / _ \ / _ \ 
| |    _   _| |__   ___ _ _| (___   ___  ___ _   _ _ __ _| |_ _   _| | | | | | | | | | | | |
| |   | | | | '_ \ / _ \ '__\___ \ / _ \/ __| | | | '__| | __| | | | | | | | | | | | | | | |
| |___| |_| | |_) |  __/ |  ____) |  __/ (__| |_| | |  | | |_| |_| | |_| | |_| | |_| | |_| |
 \_____\__, |_.__/ \___|_| |_____/ \___|\___|\__,_|_|  |_|\__|\__, |\___/ \___/ \___/ \___/ 
        __/ |                                                  __/ |                        
       |___/                                                  |___/                 
       
       Leitura de Bytes"

        echo -e "\033[00;00m"
}

leitura()
{
        echo -e "\033[01;32m"
        echo -e "###########################################"
        echo -e "|->        Leitura de bytes...          <-|"
        echo -e "###########################################"
        echo -e "\033[00;00m"
}

apres

if [ $# -ne 1 ]
then
	echo "# Usage: $0 <arquivo hexadecimal>"

else
	leitura
	for i in $(cat $1)
	do
		echo "\x$i" >> tmp1.txt
	done
	
	cat tmp1.txt | tr -d "\n" > tmp2.txt 2>/dev/null
        printf "$(cat tmp2.txt)"
fi

rm tmp1.txt 2>/dev/null
rm tmp2.txt 2>/dev/null

