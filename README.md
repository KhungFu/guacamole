Gewusst wie: Installieren Sie Apache Guacamole auf Debian/Ubuntu auf die einfachste Weise (Clientless Remote Desktop Gateway)

1 Aktualisieren Sie das System mit den folgenden Befehlen

sudo apt-Update
sudo apt upgrade -y

2 Installieren Sie Apache Guacamole
2.1 Laden Sie die .sh-Datei herunter [1]

wget -O guac-install.sh https://git.io/fxZq5
2.2 Ausführbar machen

chmod +x guac-install.sh
2.2 Führen Sie das Skript als root aus

(Interaktiv (fragt nach Passwörtern))
./guac-install.sh
Nicht-interaktiv (Werte werden über cli bereitgestellt):
./guac-install.sh --mysqlpwd Passwort --guacpwd Passwort --nomfa --installmysql
ODER

./guac-install.sh -r Passwort -gp Passwort -o -i
Nach der Installation können wir auf Guacamole zugreifen, indem Sie Folgendes öffnen: http://:8080/guacamole/ Die Standardanmeldeinformationen sind guacadmin sowohl als Benutzername als auch als Passwort . Bitte ändern Sie diese oder deaktivieren Sie guacadmin nach der Installation!

Quelle: https://dannyda.com/2020/05/23/how-to-install-apache-guacamole-on-debian-ubuntu-the-easiest-way-clientless-remote-desktop-gateway/

