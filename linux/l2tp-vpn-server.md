# L2TP/IPSec VPN Setup
https://www.osarusystem.com/misc/l2tp_ipsec_client.html
https://linuxscriptshub.com/configure-l2tp-ipsec-vpn-ubuntu-1604/
https://www.linuxhowto.net/how-to-create-your-own-ipsec-vpn-server-in-linux/
https://github.com/hwdsl2/setup-ipsec-vpn


## Install
```sh
wget https://git.io/vpnsetup-centos -O vpnsetup.sh

wget https://git.io/vpnsetup -O vpnsetup.sh

sudo VPN_IPSEC_PSK='your_ipsec_pre_shared_key' \
VPN_USER='your_vpn_username' \
VPN_PASSWORD='your_vpn_password' \
sh vpnsetup.sh

wget https://git.io/ikev2setup -O ikev2.sh
sudo bash ikev2.sh --auto

```

### Configuration
```sh
sudo nano /etc/xl2tpd/xl2tpd.conf
sudo nano /etc/ppp/options.xl2tpd
sudo nano /etc/ipsec.conf
sudo nano /etc/ipsec.secrets
sudo nano /etc/ppp/chap-secrets
```

### service
```sh
sudo systemctl status ipsec
sudo systemctl status xl2tpd
sudo systemctl enable ipsec	
sudo systemctl enable xl2tpd
sudo systemctl restart ipsec
sudo systemctl restart xl2tpd
```

### add user
```sh
wget -O add_vpn_user.sh https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/extras/add_vpn_user.sh
sudo sh add_vpn_user.sh 'username_to_add' 'user_password'
```

### delete user
```sh
wget -O del_vpn_user.sh https://raw.githubusercontent.com/hwdsl2/setup-ipsec-vpn/master/extras/del_vpn_user.sh
sudo sh del_vpn_user.sh 'username_to_delete'
```


### troubleshoot
https://github.com/hwdsl2/setup-ipsec-vpn/blob/master/docs/clients.md#windows-error-809
https://docs.microsoft.com/en-us/troubleshoot/windows-server/networking/configure-l2tp-ipsec-server-behind-nat-t-device
