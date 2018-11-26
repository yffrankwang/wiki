## status
	# sestatus

## config
	# /etc/selinux/config

## http port
	# semanage port -l | grep -w http_port_t

## add port
	# semanage port -a -t http_port_t -p tcp 8888

## delete port
	# semanage port -d -t http_port_t -p tcp 8888

