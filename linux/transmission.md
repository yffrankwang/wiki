
	sudo yum install transmission-cli transmission-daemon
	sudo systemctl enable transmission-daemon
	
	
	sudo htdigest -c /etc/httpd/conf.d/htdigest "Digest Auth" <hogeuser>

