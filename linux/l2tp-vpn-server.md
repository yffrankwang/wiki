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


### Configure a L2TP/IPsec server behind a NAT-T device

https://docs.microsoft.com/en-us/troubleshoot/windows-server/networking/configure-l2tp-ipsec-server-behind-nat-t-device


This article describes how to configure a L2TP/IPsec server behind a NAT-T device.


This section, method, or task contains steps that tell you how to modify the registry. However, serious problems might occur if you modify the registry incorrectly. Therefore, make sure that you follow these steps carefully. For added protection, back up the registry before you modify it. Then, you can restore the registry if a problem occurs. For more information about how to back up and restore the registry, see How to back up and restore the registry in Windows.

By default, Windows Vista and Windows Server 2008 don't support Internet Protocol security (IPsec) network address translation (NAT) Traversal (NAT-T) security associations to servers that are located behind a NAT device. If the virtual private network (VPN) server is behind a NAT device, a Windows Vista or Windows Server 2008-based VPN client computer can't make a Layer 2 Tunneling Protocol (L2TP)/IPsec connection to the VPN server. This scenario includes VPN servers that are running Windows Server 2008 and Windows Server 2003.

Because of the way in which NAT devices translate network traffic, you may experience unexpected results in the following scenario:

You put a server behind a NAT device.
You use an IPsec NAT-T environment.
If you must use IPsec for communication, use public IP addresses for all servers that you can connect to from the Internet. If you must put a server behind a NAT device, and then use an IPsec NAT-T environment, you can enable communication by changing a registry value on the VPN client computer and the VPN server.

Set AssumeUDPEncapsulationContextOnSendRule registry key
To create and configure the AssumeUDPEncapsulationContextOnSendRule registry value, follow these steps:

Log on to the Windows Vista client computer as a user who is a member of the Administrators group.

Select Start > All Programs > Accessories > Run, type regedit, and then select OK. If the User Account Control dialog box is displayed on the screen and prompts you to elevate your administrator token, select Continue.

Locate and then select the following registry subkey:

HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\PolicyAgent

 Note

You can also apply the AssumeUDPEncapsulationContextOnSendRule DWORD value to a Microsoft Windows XP Service Pack 2 (SP2)-based VPN client computer. To do so, locate and then select the HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\IPSec registry subkey.

On the Edit menu, point to New, and then select DWORD (32-bit) Value.

Type AssumeUDPEncapsulationContextOnSendRule, and then press ENTER.

Right-click AssumeUDPEncapsulationContextOnSendRule, and then select Modify.

In the Value Data box, type one of the following values:

0

It's the default value. When it's set to 0, Windows can't establish security associations with servers located behind NAT devices.

1

When it's set to 1, Windows can establish security associations with servers that are located behind NAT devices.

2

When it's set to 2, Windows can establish security associations when both the server and VPN client computer (Windows Vista or Windows Server 2008-based) are behind NAT devices.

Select OK, and then exit Registry Editor.

Restart the computer.
