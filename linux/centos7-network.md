### list tcp port and process
	sudo yum install lsof
	sudo lsof -i:xxx

### DNS configuration
	nmcli device
	sudo nmcli c modify <CONNECTION> ipv4.dns <IP>
	sudo nmcli c modify <CONNECTION> ipv4.ignore-auto-dns <yes/no>
	sudo systemctl restart NetworkManager
	cat /etc/resolv.conf

