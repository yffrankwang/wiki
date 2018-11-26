Zabbix Trouble Shooting
========================

## Zabbix poller processes more than 75% busy
	change StartPollers=5 -> 10

	root@zabbix-server:~# cat /etc/zabbix/zabbix_server.conf
	...
	# StartPollers=5
	StartPollers=10

## cannot create PID file [/var/run/zabbix/zabbix_agentd.pid]

	sudo nano /etc/init.d/zabbix-agent

~~~
	DIR=/var/run/zabbix
	if test ! -d "$DIR"; then
			mkdir "$DIR"
			chown -R zabbix:zabbix "$DIR"
	fi
~~~


## "Cannot open file "/var/log/tomcat/catalina.2016-03-15.log": [13] Permission denied

Config SELinux to allow zabbix to access the /var/log.

	cat /var/log/audit/audit.log | grep zabbix | audit2allow -M zabbix-agent
	semodule -i zabbix-agent.pp
