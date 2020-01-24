# svn 1.8
	wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/i686/mod_dav_svn-1.8.9-1.i686.rpm
	wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/i686/serf-1.3.7-1.i686.rpm
	wget http://opensource.wandisco.com/rhel/6/svn-1.8/RPMS/i686/subversion-1.8.9-1.i686.rpm
	sudo rpm -i serf-1.3.7-1.i686.rpm
	sudo rpm -i subversion-1.8.9-1.i686.rpm
	sudo rpm -i mod_dav_svn-1.8.9-1.i686.rpm

# svn 1.7 i686
	wget http://opensource.wandisco.com/rhel/6/svn-1.7/RPMS/i686/serf-1.3.4-1.i686.rpm
	wget http://opensource.wandisco.com/rhel/6/svn-1.7/RPMS/i686/subversion-1.7.18-1.i686.rpm
	wget http://opensource.wandisco.com/rhel/6/svn-1.7/RPMS/i686/mod_dav_svn-1.7.18-1.i686.rpm
	sudo rpm -i serf-1.3.4-1.i686.rpm
	sudo rpm -i subversion-1.7.18-1.i686.rpm
	sudo rpm -i mod_dav_svn-1.7.18-1.i686.rpm


# svn 1.7 x86_64
	wget http://opensource.wandisco.com/rhel/6/svn-1.7/RPMS/x86_64/serf-1.3.4-1.x86_64.rpm
	wget http://opensource.wandisco.com/rhel/6/svn-1.7/RPMS/x86_64/subversion-1.7.9-1.x86_64.rpm
	wget http://opensource.wandisco.com/rhel/6/svn-1.7/RPMS/x86_64/mod_dav_svn-1.7.9-1.x86_64.rpm
	sudo rpm -i serf-1.3.4-1.x86_64.rpm
	sudo rpm -i subversion-1.7.9-1.x86_64.rpm
	sudo rpm -i mod_dav_svn-1.7.9-1.x86_64.rpm


# setting
	sudo mkdir -p /home/svn/conf
	sudo htpasswd /home/svn/conf/passwd jenkins

~~~
echo "
[groups]
admin = admin
devteam = dev
docs = doc
build = jenkins

# default
[/] * = r
@admin = rw
@devteam = rw
dangerman =

# repository vendor
[vendor:/]
@devteam = rw
" | sudo tee /home/svn/conf/authz
~~~

# apache svn
	sudo yum -y install httpd subversion mod_dav_svn
	sudoc chown -R apache:apache /home/svn

~~~
echo "
<VirtualHost *:80>
	ServerName svn.xxx.com
	ServerAlias svn
	ErrorLog   /var/www/log/httpd/svn.error.log
	CustomLog \"|/usr/sbin/rotatelogs /var/www/log/httpd/svn.access.log-%Y%m%d 86400 540\" combined

	<Location /cross>
		DAV svn
		SVNPath /home/svn/cross
		AuthType Basic
		AuthName \"Authorization Realm\"
		AuthUserFile /home/svn/conf/passwd
		AuthzSVNAccessFile /home/svn/conf/authz
		Require valid-user
	</Location>

	<Location /vendor>
		DAV svn
		SVNPath /home/svn/vendor
		AuthType Basic
		AuthName \"Authorization Realm\"
		AuthUserFile /home/svn/conf/passwd
		AuthzSVNAccessFile /home/svn/conf/authz
		Require valid-user
	</Location>
</VirtualHost>

" | sudo tee -a /etc/httpd/conf.d/subversion.conf

