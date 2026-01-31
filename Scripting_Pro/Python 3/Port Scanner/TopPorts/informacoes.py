#!/usr/bin/python3

portas_top10 = [21, 22, 23, 25, 53, 80, 110, 139, 443, 445]

portas_top20 = [21, 22, 23, 25, 53, 80, 110, 139, 143, 443,
                445, 3306, 3389, 5900, 8080, 993, 995, 1723, 5060, 8443
                ]

portas_top50 = [20, 21, 22, 23, 25, 53, 69, 80, 110, 119,
		123, 137, 138, 139, 143, 161, 389, 443, 445, 465, 
		500, 512, 513, 514, 515, 587, 636, 989, 990, 993, 
		995, 1433, 1521, 2049, 2082, 2083, 2086, 2087, 2181, 2121, 
		2222, 2483, 2484, 3306, 3389, 4444, 5432, 5900, 6379, 8080, 
		8443
		]

# Menu
def menu_portas():

    print("Selecione uma lista de portas: ")
    print("1 - Lista Top 10")
    print("2 - Lista Top 20")
    print("3 - Lista Top 50")

    try:
        opc = int(input("\n# Opc: "))

        if opc == 1:
            return portas_top10

        elif opc == 2:
            return portas_top20
             
        elif opc == 3:
            return portas_top50

        else:
            return None

    except KeyboardInterrupt as e:
        print("Programa Encerrado !")

    except Exception as e:
        pass

    print("")
