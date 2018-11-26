### stop service
	sudo apachectl stop

### start service
	sudo apachectl start


### auto start service
	sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist


### enable PHP
	sudo vi /etc/apache2/httpd.conf
	- #LoadModule php5_module libexec/apache2/libphp5.so
	+ LoadModule php5_module libexec/apache2/libphp5.so


### enable vhost
	sudo vi /etc/apache2/httpd.conf
	- #Include /private/etc/apache2/extra/httpd-vhosts.conf
	+ Include /private/etc/apache2/extra/httpd-vhosts.conf


### edit vhost
	<VirtualHost *:80>
	    DocumentRoot "/Users/is0me/Dev/sandbox"
	    ServerName sandbox.localhost
	    ErrorLog "/private/var/log/apache2/sandbox-error_log"
	    CustomLog "/private/var/log/apache2/sandbox-access_log" common
	    DirectoryIndex index.php index.html

	    <Directory "/Users/is0me/Dev/sandbox">
	        Options Indexs FollowSymLinks
	        AllowOverride All    
	        order deny,allow
	        allow from All
	    </Directory>
	</VirtualHost>
