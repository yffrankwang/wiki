# iptables
@see https://www.digitalocean.com/community/tutorials/how-to-setup-a-basic-ip-tables-configuration-on-centos-6

### remove all rules
	sudo iptables -F

### blocking null packets
	sudo iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP

### reject is a syn-flood attack
	sudo iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

### reject XMAS packets
	sudo iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

### DNS
	sudo iptables -A INPUT -p udp --sport 53 -j ACCEPT
	sudo iptables -A INPUT -p udp -s $DNS_SERVER --sport 53 -j ACCEPT

### Allow any established outgoing connections to receive replies from the VPS on the other side of that connection
	sudo iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

### Ping from and to server
	sudo iptables -A INPUT  -p icmp --icmp-type echo-request -j ACCEPT

### Accept LoopBack
	sudo iptables -A INPUT  -i lo -j ACCEPT
	sudo iptables -A OUTPUT -o lo -j ACCEPT

### SSH
	sudo iptables -A INPUT -p tcp  --dport 22   -j ACCEPT

### DTI ssh port
	sudo iptables -A INPUT -p tcp  --dport 3843 -j ACCEPT

### WEB
	sudo iptables -A INPUT -p tcp --dport 80  -j ACCEPT
	sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

### SMTP
	sudo iptables -A INPUT -p tcp  --dport 25  -j ACCEPT
	sudo iptables -A INPUT -p tcp  --dport 465 -j ACCEPT

### POP3
	sudo iptables -A INPUT -p tcp  --dport 110 -j ACCEPT
	sudo iptables -A INPUT -p tcp  --dport 995 -j ACCEPT

### IMAP
	sudo iptables -A INPUT -p tcp  --dport 143 -j ACCEPT
	sudo iptables -A INPUT -p tcp  --dport 993 -j ACCEPT

### MySQL
	sudo iptables -A INPUT -p tcp  --dport 3306 -j ACCEPT

### Tomcat
	sudo iptables -A INPUT -p tcp  --dport 8080 -j ACCEPT

### APP
	sudo iptables -A INPUT -p tcp  --dport 8888 -j ACCEPT

### Jenkins
	sudo iptables -A INPUT -p tcp  --dport 9090 -j ACCEPT

### Squid
	sudo iptables -A INPUT -p tcp  --dport 3333 -j ACCEPT

### OpenVPN
	sudo iptables -A INPUT -p tcp  --dport 1194 -j ACCEPT
	sudo iptables -A INPUT -p udp  --dport 1194 -j ACCEPT


### Setting default filter policy
	sudo iptables -P OUTPUT ACCEPT
	sudo iptables -P INPUT DROP
	sudo iptables -P FORWARD DROP

### Block some ip
	sudo iptables -I INPUT -s 1.2.3.0/24 -j DROP

### List
	sudo iptables -L -n

### Save
	sudo iptables-save | sudo tee /etc/sysconfig/iptables

### Restart
	sudo service iptables restart


## Port FORWARD

### Add 443 -> 8080
	sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080

### Remove
	sudo iptables -D PREROUTING -t nat -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8080

