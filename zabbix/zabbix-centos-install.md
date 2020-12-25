zabbix server
-----------------------

## dependency (deprecated)
	yum install OpenIPMI-libs fping iksemel net-snmp unixODBC
	yum install epel-release
	yum install --enablerepo=epel iksemel
	yum install --enablerepo=epel fping iksemel
	yum install mariadb mariadb-server php php-fpm 
	yum install vlgothic-p-fonts
	yum install mailx

## install
@see https://www.zabbix.com/documentation/2.4/manual/installation/install_from_packages

	sudo rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
	sudo yum install zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese zabbix-agent


## mysql config
	cd /usr/share/doc/zabbix-server-mysql-2.4.?/create
	mysql -u root <<EOF
		create database zabbix character set utf8 collate utf8_bin;
		grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';

		-- initial schema
		use zabbix;
		source schema.sql
		source images.sql
		source data.sql

		-- reset Admin password
		update users set passwd=md5('password');
	EOF

## zabbix server config
	sudo cp /etc/zabbix/zabbix_server.conf /etc/zabbix/zabbix_server.conf.org
	sudo sed \
	-e "s/# DBHost=localhost/DBHost=localhost/" \
	-e "s/# DBPassword=/DBPassword=zabbix/" \
	-e "s/DBUser=.*/DBUser=zabbix/" \
	-e "s/StartPollers=.*/StartPollers=20/" \
	-e "s/# StartPollersUnreachable=.*/StartPollersUnreachable=5/" \
	/etc/zabbix/zabbix_server.conf.org | sudo tee /etc/zabbix/zabbix_server.conf

## start zabbix server
#### centos6
	sudo chkconfig zabbix-server on
	sudo service zabbix-server start

#### centos7
	sudo systemctl enable zabbix-server
	sudo systemctl start zabbix-server

## japanese font (deprecated)

~~~
	#sudo yum install ipa-gothic-fonts
	#sudo ln -s /usr/share/fonts/ipa-gothic/ipag.ttf /usr/share/zabbix/fonts/ipag.ttf

	# sudo nano /usr/share/zabbix/include/defines.inc.php
	# define('ZBX_GRAPH_FONT_NAME', 'ipag');
~~~


## Nginx GUI
	sudo chown -R nginx:nginx /etc/zabbix/web

~~~
echo '
server {
    listen 80;
    server_name _;
    return 302 https://$http_host$request_uri;
}

server {
    listen       443 ssl;
    server_name  _;

    ssl_certificate      /etc/nginx/conf.d/lets.crt;
    ssl_certificate_key  /etc/nginx/conf.d/lets.key;

    charset utf-8;

    index         index.php;

    location / {
        root /usr/share/zabbix/;
        index index.php index.html;
    }
    
    # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
    #
    location ~ \.php$ {
        fastcgi_pass   unix:/var/run/php-fpm/php-fpm.sock;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  /usr/share/zabbix/$fastcgi_script_name;
        include        fastcgi_params;
        fastcgi_buffers 16 16k;
        fastcgi_buffer_size 32k;
        client_max_body_size 0;
    }
}
' | sudo tee /etc/nginx/conf.d/zabbix.conf
~~~


If zabbix install by GUI can not performed, try the following command.
~~~
echo "
<?php
// Zabbix GUI configuration file
global \$DB;

\$DB['TYPE']     = 'MYSQL';
\$DB['SERVER']   = 'localhost';
\$DB['PORT']     = '0';
\$DB['DATABASE'] = 'zabbix';
\$DB['USER']     = 'zabbix';
\$DB['PASSWORD'] = 'zabbix';

// SCHEMA is relevant only for IBM_DB2 database
\$DB['SCHEMA'] = '';

\$ZBX_SERVER      = 'localhost';
\$ZBX_SERVER_PORT = '10051';
\$ZBX_SERVER_NAME = '';

\$IMAGE_FORMAT_DEFAULT = IMAGE_FORMAT_PNG;
?>
" | sudo tee /etc/zabbix/web/zabbix.conf.php
~~~


## SELinux trouble
getsebool -a|grep zabbix
	httpd_can_connect_zabbix --> off
	zabbix_can_network --> off


setsebool -P httpd_can_connect_zabbix on
setsebool -P zabbix_can_network on



linux client
-------------------

@see https://www.zabbix.com/documentation/2.4/manual/installation/install_from_packages

~~~
sudo rpm -ivh http://repo.zabbix.com/zabbix/2.4/rhel/6/x86_64/zabbix-release-2.4-1.el6.noarch.rpm
sudo yum install -y zabbix-agent

sudo mv /etc/zabbix/zabbix_agentd.conf /etc/zabbix/zabbix_agentd.conf.org
sudo sed \
-e "s/LogFileSize=0/LogFileSize=1/" \
-e "s/Server=.*/Server=x.x.x.x/" \
-e "s/# StartAgents=.*/StartAgents=1/" \
-e "s/ServerActive=.*/ServerActive=x.x.x.x/" \
-e "s/Hostname=.*/Hostname=x.x.x.x/" \
/etc/zabbix/zabbix_agentd.conf.org | sudo tee /etc/zabbix/zabbix_agentd.conf
diff /etc/zabbix/zabbix_agentd.conf.org /etc/zabbix/zabbix_agentd.conf
~~~

#### centos6
	sudo chkconfig zabbix-agent on
	sudo service zabbix-agent start

#### centos7
	sudo systemctl enable zabbix-agent
	sudo systemctl start zabbix-agent



windows agent
------------------

	wget http://www.zabbix.com/downloads/2.4.4/zabbix_agents_2.4.4.win.zip
	zabbix_agentd.exe --config c:\zabbix\conf\zabbix_agentd.win.conf --install

