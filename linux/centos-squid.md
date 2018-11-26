## install squid
sudo yum -y install squid httpd-tools

## settings
~~~
sudo mv /etc/squid/squid.conf /etc/squid/squid.conf.org
sudo sed \
-e 's/http_port 3128/http_port 3333/' \
-e 's/http_access deny CONNECT !SSL_ports/#http_access deny CONNECT !SSL_ports/' \
-e 's/#http_access deny to_localhost/http_access deny to_localhost/' \
-e 's/acl CONNECT method CONNECT/acl CONNECT method CONNECT\
\
forwarded_for off\
visible_hostname unknown\
\
request_header_access Referer deny all\
request_header_access X-Forwarded-For deny all\
request_header_access Via deny all\
request_header_access Cache-Control deny all\
\
access_log \/var\/log\/squid\/access.log auto\
emulate_httpd_log on\
\
#### centos6 32bit\
#### auth_param basic program \/usr\/lib\/squid\/ncsa_auth \/etc\/squid\/passwd\
#### centos6 64bit\
#### auth_param basic program \/usr\/lib64\/squid\/ncsa_auth \/etc\/squid\/passwd\
#### centos7 64bit\
auth_param basic program /usr/lib64/squid/basic_ncsa_auth /etc/squid/passwd
auth_param basic children 1\
auth_param basic realm Squid proxy-caching web server\
auth_param basic credentialsttl 2 hours\
\
acl ncsa_users proxy_auth REQUIRED\
http_access allow ncsa_users\
/' \
/etc/squid/squid.conf.org | sudo tee /etc/squid/squid.conf
sudo diff /etc/squid/squid.conf.org /etc/squid/squid.conf
~~~

## basic auth ( user / password )
	sudo htpasswd -c /etc/squid/passwd user

## start
	sudo service squid start

## auto
	sudo chkconfig squid on

