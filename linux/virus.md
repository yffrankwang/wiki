### virus scan
@see http://qiita.com/todaemon/items/d83425058c0e52b258c7

	yum install epel-release
	yum install clamd
	chkconfig clamd on
	
	####### check selinux virus scan rule
	sesearch -b antivirus_can_scan_system -AC
	
	####### enable virus scan
	setsebool -P antivirus_can_scan_system on
	
	service clamd start

	###### update virus databases
	freshclam
	
	####### test scan
	clamdscan /bin/
