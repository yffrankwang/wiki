### 
	sudo yum install golang fuse git lsof -y
	wget https://bootstrap.pypa.io/get-pip.py
	sudo python get-pip.py
	sudo pip install awscli

### Build
	export GOPATH=$HOME/go
	go get github.com/kahing/goofys
	go install github.com/kahing/goofys
	$GOPATH/bin/goofys -h


### Release
	wget https://github.com/kahing/goofys/releases/download/v0.0.8/goofys -P /usr/local/bin/
	sudo chmod 755 /usr/local/bin/goofys
	/usr/local/bin/goofys -h
	

### AWS CONFIG
	$ aws configure 
	AWS Access Key ID [None]: 
	AWS Secret Access Key [None]: 
	Default region name [None]: 
	Default output format [None]:

	$ cat ~/.aws/credentials
	[default]
	aws_access_key_id = AKID1234567890
	aws_secret_access_key = MY-SECRET-KEY

### Mount
	$ mkdir <Mount Point>
	$ sudo /usr/local/bin/goofys --uid=<UID> --gid=<GID> --dir-mode=0774 --file-mode=0664 <Bucket Name> <Mount Point>

### CONFIRM
	$ ps auxf | grep goofys
	$ df -h
	$ sudo grep goofys /var/log/messages

### Umount
	$ umount <Mount Point>

### fstab
	echo "/usr/local/bin/goofys#<Bucket Name>  <Mount Point>  fuse  _netdev,allow_other,--uid=<UID>,--gid=<GID>,--dir-mode=0774,--file-mode=0664,--acl=public-read 0 0" | sudo tee -a /etc/fstab

### cloudn fstab
	echo "/usr/local/bin/goofys#<Bucket Name>  <Mount Point>  fuse  _netdev,allow_other,--uid=<UID>,--gid=<GID>,--dir-mode=0774,--file-mode=0664,--acl=public-read,--endpoint=str.cloudn-service.com 0 0" | sudo tee -a /etc/fstab
