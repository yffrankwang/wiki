## install samba

	sudo yum -y install samba


## firewall

	sudo firewall-cmd --permanent --add-port=445/tcp
	sudo firewall-cmd --reload
	sudo firewall-cmd --list-ports

## config samba

	sudo nano /etc/samba/smb.conf

~~~
[global]

	# for windows 2003
	server min protocol = NT1
	ntlm auth = yes

	# for symlink
	unix extensions = no
	wide links = yes


[proj]
	path = /proj
	browsable = yes
	writeable = yes
	create mask = 0666
	directory mask = 0777
	guest ok = no
	read only = no
~~~


## add samba user

	sudo pdbedit -a user1


## start samba

	systemctl start  smb
	systemctl enable smb 
