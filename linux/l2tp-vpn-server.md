# Ubuntu L2TP/IPSec VPN Setup
https://www.osarusystem.com/misc/l2tp_ipsec_client.html
https://linuxscriptshub.com/configure-l2tp-ipsec-vpn-ubuntu-1604/
https://www.linuxhowto.net/how-to-create-your-own-ipsec-vpn-server-in-linux/
https://github.com/hwdsl2/setup-ipsec-vpn


## CentOS/RHEL
```sh
wget https://git.io/vpnsetup-centos -O vpnsetup.sh
VPN_IPSEC_PSK='KvLjedUkNzo5gBH72SqkOA=='
VPN_USER='tecmint'
VPN_PASSWORD='8DbDiPpGbcr4wQ=='
sudo sh vpnsetup.sh
```


## Debian and Ubuntu
```sh
wget https://git.io/vpnsetup -O vpnsetup.sh
VPN_IPSEC_PSK='KvLjedUkNzo5gBH72SqkOA=='
VPN_USER='tecmint'
VPN_PASSWORD='8DbDiPpGbcr4wQ=='
sudo sh vpnsetup.sh
```

## Configuration
```sh
sudo nano /etc/xl2tpd/xl2tpd.conf
sudo nano /etc/ppp/options.xl2tpd
sudo nano /etc/ipsec.d/l2tp-ipsec.conf
sudo nano /etc/ppp/chap-secrets
sudo nano /etc/ipsec.d/default.secrets
```
