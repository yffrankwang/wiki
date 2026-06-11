https://wiki.ubuntu.com/MountWindowsSharesPermanently

### prepare

	sudo apt update
	sudo apt install cifs-utils


### mount

	sudo mkdir /mnt/cifs
	sudo mount -t cifs -o username=admin,password=xxxx,iocharset=utf8,vers=1.0 '//server/share' /mnt/share



### fstab

	//servername/share  /mnt/share  cifs  guest,uid=1000,iocharset=utf8,errors=continue  0  0


