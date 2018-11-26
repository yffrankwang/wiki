### timezone
> sudo cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
> sudo nano /etc/sysconfig/clock

	ZONE="Asia/Tokyo"


### hostname
> sudo nano /etc/sysconfig/network

    HOSTNAME=xxx


### user
    useradd ou
    passwd ou
    usermod -a -G wheel ou

### static IP
/etc/sysconfig/network-scripts/ifcfg-eth0

	ONBOOT=yes
	BOOTPROTO=static
	DNS1="8.8.8.8"
	DNS2="8.8.4.4"
	DOMAIN=mydomain.com
	IPADDR=192.168.100.11
	NETMASK=255.255.255.0
	GATEWAY=192.168.100.1

### alternatives

	ll /var/lib/alternatives
	sudo alternatives --config java
	sudo alternatives --config javac
	sudo alternatives --config java_sdk_openjdk
