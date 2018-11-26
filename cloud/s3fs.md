### Download
	git clone https://github.com/s3fs-fuse/s3fs-fuse.git
	cd s3fs-fuse/

### For Cloudn
	sed -i "s/https:\/\/s3.amazonaws.com/https:\/\/str.cloudn-service.com/g" src/s3fs.cpp
	sed -i "s/https:\/\/s3.amazonaws.com/https:\/\/str.cloudn-service.com/g" src/s3fs_util.cpp
	grep cloudn-service src/s3fs.cpp src/s3fs_util.cpp

### Build
	sudo yum -y install git gcc-c++ fuse fuse-devel libcurl-devel libxml2-devel openssl-devel automake
	./autogen.sh
	./configure
	make
	sudo make install

### S3 Identity
	echo "<Access Key ID>:<Secret Access Key>" | sudo tee -a /etc/passwd-s3fs
	sudo chmod 640 /etc/passwd-s3fs

### Mount
	mkdir <Mount Point>
	sudo /usr/local/bin/s3fs  <Bucket Name>  <Mount Point>  -o rw,allow_other,umask=0002,uid=<UID>,gid=<GID>,default_acl=public-read

### Umount
	$ umount <Mount Point>

### fstab
	echo "/usr/local/bin/s3fs#<Bucket Name>  <Mount Point>  fuse  rw,allow_other,umask=0002,uid=<UID>,gid=<GID>,default_acl=public-read 0 0" | sudo tee -a /etc/fstab

### Confirm
	$ df -h

### Debug
	sudo /usr/local/bin/s3fs  <Bucket Name>  <Mount Point>  -d -o ...

### Log
	$ sudo tail /var/log/messages | grep s3fs

