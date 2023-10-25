#!/bin/sh

username="useradd -m videocall"
if id "$username" &>/dev/null; then
    echo "videocall is installed."
else
    sudo wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/mahmoud-ap/badvpn/master/badvpn-udpgw"
    mv -f ./badvpn-udpgw /usr/bin/badvpn-udpgw
    chmod 777 /usr/bin/badvpn-udpgw
    useradd -m videocall
fi

cat >  /etc/systemd/system/videocall.service << ENDOFFILE
[Unit]
Description=UDP forwarding for badvpn-tun2socks
After=nss-lookup.target

[Service]
ExecStart=/usr/bin/badvpn-udpgw --loglevel none --listen-addr 127.0.0.1:7301 --max-clients 999
User=videocall

[Install]
WantedBy=multi-user.target
ENDOFFILE

systemctl enable videocall
systemctl start videocall
   