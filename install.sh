#!/bin/sh
sudo wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/mahmoud-ap/badvpn/master/badvpn-udpgw"
sudo touch /etc/rc.local
sudo nano /etc/rc.local

cat >  /etc/rc.local << ENDOFFILE
#!/bin/sh -e
screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
exit 0
ENDOFFILE

chmod +x /etc/rc.local
sudo systemctl status rc-local.service
sudo chmod +x /usr/bin/badvpn-udpgw
sudo screen -AmdS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300
