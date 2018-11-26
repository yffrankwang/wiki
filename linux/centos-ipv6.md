## disable IP v6
/etc/sysctl.conf
Put the following entry to disable IPv6 for all adapter.

	net.ipv6.conf.all.disable_ipv6 = 1
	net.ipv6.conf.default.disable_ipv6 = 1

For particular adapter. (If the network card name is eno16777736).

	net.ipv6.conf.eno16777736.disable_ipv6 = 1

To reflect the changes by executing the following command.

	# sysctl -p