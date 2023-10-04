#!/bin/sh
OS=`uname -m`;
sudo wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/mahmoud-ap/badvpn/master/badvpn-udpgw"
if [ "$OS" == "x86_64" ]; then
  sudo wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/mahmoud-ap/badvpn/master/badvpn-udpgw64"
fi
sudo touch /etc/rc.local
sudo echo "\nscreen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300" >> /etc/rc.local
sudo chmod +x /usr/bin/badvpn-udpgw
sudo screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300