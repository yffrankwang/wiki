 services
-------------------------------

### ssh
	sudo apt-get install ssh
	sudo service ssh start

### ftp daemon
~~~
sudo apt-get install vsftpd
sudo sed \
  -e "s/#write_enable=YES/write_enable=YES/" \
  -e "s/#local_umask=022/local_umask=022/" \
  /etc/vsftpd.conf > /tmp/vsftpd.conf
sudo mv /tmp/vsftpd.conf /etc/
~~~

### samba
~~~
sudo apt-get install samba
sudo smbpasswd -a username
~~~

### disable cups-browsed (A daemon for browsing the Bonjour broadcasts of shared, remote CUPS printers)
	sudo systemctl disable cups-browsed

