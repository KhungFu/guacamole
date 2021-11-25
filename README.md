Gewusst wie: Installieren Sie Apache Guacamole auf Debian/Ubuntu auf die einfachste Weise (Clientless Remote Desktop Gateway)


1 Aktualisieren Sie das System mit den folgenden Befehlen

	sudo apt update
	sudo apt upgrade -y
  
2 Installieren Sie Apache Guacamole

2.1 Laden Sie die .sh-Datei herunter

	wget -O guac-install.sh https://git.io/fxZq5
  
2.2 Ausführbar machen

	chmod +x guac-install.sh
  
2.2 Führen Sie das Skript als root aus (Interaktiv (fragt nach Passwörtern)) 

	./guac-install.sh 
  
Nicht-interaktiv (Werte werden über cli bereitgestellt): 

	./guac-install.sh --mysqlpwd password --guacpwd password --nomfa --installmysql 
  
ODER

	./guac-install.sh -r password -gp password -o -i 
  
Nach der Installation können wir auf Guacamole zugreifen, wenn Sie Folgendes öffnen: http://Ihre_IP_Adresse:8080/guacamole/


Die Standardanmeldeinformationen sowohl als Benutzername als auch als Passwort sind: "guacadmin"!


Bitte ändern Sie diese oder deaktivieren Sie nach der Installation!


Quelle: https://dannyda.com/2020/05/23/how-to-install-apache-guacamole-on-debian-ubuntu-the-easiest-way-clientless-remote-desktop-gateway/
