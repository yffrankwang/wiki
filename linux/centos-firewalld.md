# firewalld

## install
```sh
sudo yum -y install firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld
sudo systemctl is-enabled firewalld
```

### list
```sh
sudo firewall-cmd --list-all
sudo firewall-cmd --list-services --zone=public --permanent
```

### add service
```sh
sudo firewall-cmd --permanent --zone=public --add-service=ftp
sudo firewall-cmd --permanent --zone=public --add-service=http
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --permanent --zone=public --add-service=smtp
sudo firewall-cmd --permanent --zone=public --add-service=pop3
sudo firewall-cmd --permanent --zone=public --add-service=imap
sudo firewall-cmd --permanent --zone=public --add-service=smtps
sudo firewall-cmd --permanent --zone=public --add-service=pop3s
sudo firewall-cmd --permanent --zone=public --add-service=imaps
```

### add port
```sh
sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --permanent --zone=public --add-port=4000-4029/tcp
```

### port forward
```sh
sudo firewall-cmd --permanent --add-forward-port=port=80:proto=tcp:toport=12000
sudo firewall-cmd --permanent --add-forward-port=port=443:proto=tcp:toport=12443

sudo firewall-cmd --permanent --remove-forward-port=port=80:proto=tcp:toport=12000
sudo firewall-cmd --permanent --remove-forward-port=port=443:proto=tcp:toport=12443
```

### reload
```sh
sudo firewall-cmd --reload
```