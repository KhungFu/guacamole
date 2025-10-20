#!/bin/bash
set -e


# ================================
# Guacamole + Tomcat 10 Install Script
# ================================


echo "🧹 Entferne alte Guacamole-Installation..."
sudo systemctl stop guacd>/dev/null || true
sudo systemctl disable guacd>/dev/null || true
sudo rm -f /etc/init.d/guacd
sudo rm -f /usr/local/sbin/guacd
sudo rm -rf /etc/guacamole /usr/local/share/guacamole /usr/local/lib/guacamole /usr/local/etc/guacamole /usr/local/var/guacamole


echo "📦 Installiere benötigte Pakete..."
sudo apt update
sudo apt install -y build-essential libcairo2-dev libjpeg62-turbo-dev libpng-dev \
libtool-bin libossp-uuid-dev libavcodec-dev libavformat-dev libavutil-dev \
freerdp2-dev libpango1.0-dev libssh2-1-dev libtelnet-dev libvncserver-dev \
libpulse-dev libssl-dev libvorbis-dev libwebp-dev wget curl tar tomcat10


# Sicherstellen, dass Tomcat läuft
echo "☕ Starte Tomcat 10..."
sudo systemctl enable tomcat10
sudo systemctl restart tomcat10


echo "⬇️ Lade Guacamole Server 1.5.5 herunter..."
cd /tmp
wget -q https://downloads.apache.org/guacamole/1.5.5/source/guacamole-server-1.5.5.tar.gz
tar -xzf guacamole-server-1.5.5.tar.gz
cd guacamole-server-1.5.5


echo "⚙️ Baue und installiere Guacamole Server..."
sudo ./configure --with-init-dir=/etc/init.d
sudo make
sudo make install
sudo ldconfig
sudo systemctl daemon-reload


echo "🔧 Starte guacd..."
sudo systemctl enable guacd
sudo systemctl restart guacd


# Guacamole Webapp in Tomcat deployen
echo "⬇️ Lade Guacamole Webapp 1.5.5..."
wget -q https://downloads.apache.org/guacamole/1.5.5/binary/guacamole-1.5.5.war -O /tmp/guacamole.war


sudo mkdir -p /etc/guacamole
sudo mv /tmp/guacamole.war /var/lib/tomcat10/webapps/guacamole.war


# Benutzerabfrage
read -p "Gib den Guacamole-Benutzernamen ein: " GUAC_USER
read -s -p "Gib das Passwort ein: " GUAC_PASS
echo


# Beispiel-Konfig-Dateien
cat <<EOF | sudo tee /etc/guacamole/guacamole.properties
guacd-hostname: localhost
guacd-port: 4822
user-mapping: /etc/guacamole/user-mapping.xml
EOF


# User Mapping mit Benutzereingabe
cat <<EOF | sudo tee /etc/guacamole/user-mapping.xml
<user-mapping>
    <authorize username="$GUAC_USER" password="$GUAC_PASS">
        <connection name="Meine Verbindung">
            <protocol>vnc</protocol>
            <param name="hostname">127.0.0.1</param>
            <param name="port">5901</param>
        </connection>
    </authorize>
</user-mapping>
EOF


sudo systemctl restart tomcat10


echo "✅ Installation abgeschlossen!"
echo "🔹 Guacamole verfügbar unter: http://$(hostname -I | awk '{print $1}'):8080/guacamole"
echo "🔹 Benutzer: $GUAC_USER"
sudo systemctl status guacd --no-pager
sudo systemctl status tomcat10 --no-pager