# CentOS7 OpenVPN Setup
https://4thsight.xyz/18104
https://qiita.com/kapioz/items/5b75c3470a4e57d916ba

## Install
prerequisite: disable SELinux

```sh
sudo yum install epel-release
sudo yum update
sudo yum install openvpn easy-rsa
```

## RSA Configuration
```sh
cd /usr/share/easy-rsa/3
sudo ./easyrsa init-pki
sudo ./easyrsa build-ca
sudo ./easyrsa build-server-full server nopass
sudo ./easyrsa build-client-full user1 nopass
sudo openvpn --genkey --secret ta.key
sudo ./easyrsa gen-dh
```

## OpenVPN Configuration
```sh
sudo cp -p ta.key pki/ca.crt pki/dh.pem pki/private/server.key pki/issued/server.crt /etc/openvpn/
sudo cp -p /usr/share/doc/openvpn-2.4.?/sample/sample-config-files/server.conf /etc/openvpn/
sudo nano /etc/openvpn/server.conf
```

~~~
push "route 10.0.0.0 255.255.255.0"
push "redirect-gateway def1"
~~~


## forward
```sh
echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf
```


## iptables
```sh
ip -4 addr show scope global
sudo iptables -A FORWARD -i enp0s3 -o tun0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i tun0 -o enp0s3 -j ACCEPT
sudo iptables -A FORWARD -i tun0 -o tun0 -j ACCEPT
sudo iptables -A FORWARD -d 10.8.0.0/24 -i enp0s3 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -s 10.8.0.0/24 -o enp0s3 -j ACCEPT
sudo iptables -A FORWARD -s 10.8.0.0/24 -o tun0 -j ACCEPT

sudo iptables -A FORWARD -i tun0 -o eth0 -s 10.8.0.0/24 -m state --state NEW -j ACCEPT
sudo iptables -A FORWARD -i tun0 -m state --state ESTABLISHED,RELATED -j ACCEPT

sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
sudo iptables-save | sudo tee -a /etc/sysconfig/iptables
echo 'iptables-restore < /etc/sysconfig/iptables' | sudo tee -a /etc/rc.local
```


## firewall
```sh
sudo firewall-cmd --permanent --add-port=1194/udp
sudo firewall-cmd --permanent --add-masquerade
sudo firewall-cmd --reload
```

## OpenVPN service
```sh
sudo systemctl enable openvpn@server
sudo systemctl start openvpn@server
```

## client 
sudo cp -p ta.key pki/ca.crt pki/issued/server.crt pki/private/user1.key  pki/issued/user1.crt ~/openvpn/
sudo cp -p /usr/share/doc/openvpn-2.4.?/sample/sample-config-files/client.conf ~/openvpn/
