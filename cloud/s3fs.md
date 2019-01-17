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

### Trouble shooting (Failed to set public-read ACL)
	> cp: cannot create regular file ‘1.txt’: Operation not permitted

	<?xml version="1.0" encoding="UTF-8"?>
	<Error><Code>AccessDenied</Code><Message>Access Denied</Message></Error>
	
	Manage public access control lists (ACLs) for this bucket

AWS Console / S3 / <Bucket Name> / Permissions

Uncheck all recommended options:

Manage public access control lists (ACLs) for this bucket
Access control lists (ACLs) are used to grant basic read/write permissions to other AWS accounts.
□　Block new public ACLs and uploading public objects (Recommended)
□　Remove public access granted through public ACLs (Recommended)

Manage public bucket policies for this bucket
Bucket policies use JSON-based access policy language to manage advanced permission to your Amazon S3 resources.
□　Block new public bucket policies (Recommended)
□　Block public and cross-account access if bucket has public policies (Recommended) 

