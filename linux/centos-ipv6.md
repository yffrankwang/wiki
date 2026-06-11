## confirm

ip addr show


## disable IP v6
sudo nano /etc/sysctl.conf

Put the following entry to disable IPv6 for all adapter.

	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1

For particular adapter. (If the network card name is eno16777736).

	net.ipv6.conf.eno16777736.disable_ipv6 = 1

To reflect the changes by executing the following command.

> sudo sysctl -p
> sudo systemctl restart network


## enable IP v6
sudo nano /etc/sysctl.conf

Put the following entry to enable IPv6 for all adapter.
```
net.ipv6.conf.all.disable_ipv6 = 0
net.ipv6.conf.default.disable_ipv6 = 0
```

### enable DHCP IPv6
sudo nano  /etc/sysconfig/network-scripts/ifcfg-eno1

IPV6INIT=yes
DHCPV6C=yes

