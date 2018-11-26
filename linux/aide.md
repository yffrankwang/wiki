# AIDE File Compare

@see http://techblog.clara.jp/2015/04/aide_install_and_setting/

## Install
	# yum install aide

## Configuration
	# nano /etc/aide.conf

## Create database
	# aide -i
	
	AIDE, version 0.15.1
	### AIDE database at /var/lib/aide/aide.db.new.gz initialized.


## Update database
	# aide -u


## Use new database
	# mv -f /var/lib/aide/aide.db.new.gz /var/lib/aide/aide.db.gz


## Check
	# aide -C
	
	AIDE, version 0.14
	### All files match AIDE database. Looks okay!
	
	AIDE found differences between database and filesystem!!
	Start timestamp: 2015-04-06 12:12:59
	
	Summary:
	 Total number of files: 18
	 Added files: 1
	 Removed files: 0
	 Changed files: 1
	 
	---------------------------------------------------
	Added files:
	---------------------------------------------------
	added: /root/test
	
	---------------------------------------------------
	Changed files:
	---------------------------------------------------
	
	changed: /root
	
	--------------------------------------------------
	Detailed information about changes:
	---------------------------------------------------
	
	
	Directory: /root
	 Mtime : 2014-09-30 17:17:02 , 2015-04-06 12:12:56
	 Ctime : 2014-09-30 17:17:02 , 2015-04-06 12:12:56

