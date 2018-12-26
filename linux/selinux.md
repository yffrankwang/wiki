## status
	# sestatus

## disable temporary
	setenforce 0

## disable permanently
	cp /etc/selinux/config /tmp/selinux.conf
	sed -e 's/SELINUX=enforcing/SELINUX=disabled/' /tmp/selinux.conf > /etc/selinux/config

## config
	# /etc/selinux/config

## http port
	# semanage port -l | grep -w http_port_t

## add port
	# semanage port -a -t http_port_t -p tcp 8888

## delete port
	# semanage port -d -t http_port_t -p tcp 8888

