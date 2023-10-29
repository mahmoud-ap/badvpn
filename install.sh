#!/bin/sh

local username="videocall"

if grep -q "^$username:" /etc/passwd; then
    echo "videocall is installed."
else
    local vendorId=$(lscpu | awk -F': ' '/Vendor ID/ {gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2}')
    if [ "$vendorId" = "ARM" ]; then
        sudo wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/mahmoud-ap/badvpn/master/udpgw-arm"
    else
        sudo wget -O /usr/bin/badvpn-udpgw "https://raw.githubusercontent.com/mahmoud-ap/badvpn/master/udpgw-x86"
    fi
    chmod 777 /usr/bin/badvpn-udpgw
    useradd -m videocall
fi

cat >  /etc/systemd/system/videocall.service << ENDOFFILE
[Unit]
Description=UDP forwarding for badvpn-tun2socks
After=nss-lookup.target

[Service]
ExecStart=/usr/bin/badvpn-udpgw --loglevel none --listen-addr 127.0.0.1:7302 --max-clients 999
User=videocall

[Install]
WantedBy=multi-user.target
ENDOFFILE

systemctl enable videocall
systemctl start videocall

echo "videocall configured"
