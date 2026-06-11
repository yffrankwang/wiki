# Run dhclient on boot
echo '[Unit]
Description=Run dhclient on boot
After=syslog.target network.target local-fs.target

[Service]
Type=simple
ExecStart=/usr/sbin/dhclient -6 ens3

[Install]
WantedBy=multi-user.target
' | sudo tee /usr/lib/systemd/system/dhcpv6.service

sudo systemctl enable dhcpv6.service
