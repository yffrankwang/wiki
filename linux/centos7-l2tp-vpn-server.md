# CentOS7 L2TP/IPSec VPN Setup

## Install
prerequisite: disable SELinux

```sh
sudo yum install epel-release
sudo yum update
sudo yum install xl2tpd libreswan
```

## Configuration
```sh
export MYIP=1.2.3.4
sudo nano /etc/xl2tpd/xl2tpd.conf
```

~~~
[global]
listen-addr = ${MYIP}

[lns default]
ip range = 192.168.1.128-192.168.1.254
local ip = 192.168.1.99
require chap = yes
refuse pap = yes
require authentication = yes
name = xl2tpd
ppp debug = yes
pppoptfile = /etc/ppp/options.xl2tpd
length bit = yes
~~~

```sh
echo '
name xl2tpd
refuse-pap
refuse-chap
refuse-mschap
require-mschap-v2
persist
logfile /var/log/xl2tpd.log
' | sudo tee -a /etc/ppp/options.xl2tpd

sudo touch /var/log/xl2tpd.log
```

```sh
echo '
"username"	"xl2tpd"	"password"	*
' | sudo tee -a /etc/ppp/chap-secrets
```

```sh
echo "
conn L2TP-PSK-NAT
    rightsubnet=0.0.0.0/0
    dpddelay=10
    dpdtimeout=20
    dpdaction=clear
    forceencaps=yes
    also=L2TP-PSK-noNAT
conn L2TP-PSK-noNAT
    authby=secret
    pfs=no
    auto=add
    keyingtries=3
    rekey=no
    ikelifetime=8h
    keylife=1h
    type=transport
    left=${MYIP}
    leftprotoport=17/1701
    right=%any
    rightprotoport=17/%any
" | sudo tee -a /etc/ipsec.d/l2tp-ipsec.conf
```

```sh
echo ': PSK "preshared-key"' | sudo tee -a /etc/ipsec.d/default.secrets
sudo chmod 600 /etc/ipsec.d/default.secrets
```

## firewall
```sh
sudo firewall-cmd --permanent --add-service=ipsec
sudo firewall-cmd --permanent --add-port=1701/udp
sudo firewall-cmd --permanent --add-port=4500/udp
sudo firewall-cmd --permanent --add-masquerade
sudo firewall-cmd --reload
```

## sysctl
```sh
echo '
net.ipv4.ip_forward = 1
net.ipv4.conf.all.accept_redirects = 0
net.ipv4.conf.all.rp_filter = 0
net.ipv4.conf.all.send_redirects = 0
net.ipv4.conf.default.accept_redirects = 0
net.ipv4.conf.default.rp_filter = 0
net.ipv4.conf.default.send_redirects = 0
net.ipv4.conf.eth0.accept_redirects = 0
net.ipv4.conf.eth0.rp_filter = 0
net.ipv4.conf.eth0.send_redirects = 0
net.ipv4.conf.lo.accept_redirects = 0
net.ipv4.conf.lo.rp_filter = 0
net.ipv4.conf.lo.send_redirects = 0
' | sudo tee -a /etc/sysctl.d/60-ipsec.conf

sudo sysctl --system
```

## service
```sh
sudo systemctl enable ipsec
sudo systemctl enable xl2tpd
sudo systemctl restart ipsec
sudo systemctl restart xl2tpd
```

## verify
```sh
 ipsec verify
```

## centos6: iptables (for internet access)
```sh
sudo iptables -A FORWARD -i ppp+ -j ACCEPT
sudo iptables -A FORWARD -o ppp+ -j ACCEPT
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -p esp -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 1701 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 500 -j ACCEPT
sudo iptables -A INPUT -p udp -m udp --dport 4500 -j ACCEPT

sudo iptables -A INPUT -j REJECT --reject-with icmp-host-prohibited
sudo iptables -A FORWARD -j REJECT --reject-with icmp-host-prohibited

sudo iptables -A POSTROUTING -s 192.168.1.128/25 -j MASQUERADE
```
