zabbix server
-----------------------

sudo yum install httpd mod_ssl 

sudo amazon-linux-extras install epel
sudo amazon-linux-extras install php7.2

## zabbix install
echo '[amazon.zabbix]
name=Amazon-Zabbix
baseurl=https://s3-ap-northeast-1.amazonaws.com/amazon.zabbix/amzn2/5.0/$basearch
gpgcheck=0
' | sudo tee -a /etc/yum.repos.d/zabbix.repo


sudo yum update
sudo yum install zabbix-server-mysql zabbix-web-mysql zabbix-web-japanese zabbix-agent

## mysql config
	sudo yum install mariadb mariadb-server
	mysql -u root <<EOF
		create database zabbix character set utf8 collate utf8_bin;
		grant all privileges on zabbix.* to zabbix@localhost identified by 'zabbix';

		-- reset Admin password
		update users set passwd=md5('password');
	EOF

	zcat /usr/share/doc/zabbix-server-mysql-5.0.6/create.sql.gz | mysql -uzabbix -pzabbix zabbix

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
	sudo systemctl enable zabbix-server
	sudo systemctl start zabbix-server


## Apach GUI
~~~
echo '
<VirtualHost *:80>
        ServerName zabbix.sample.net
        RewriteEngine On
        LogLevel alert rewrite:trace3
        RewriteCond %{HTTPS} off
        RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [R,L]
</VirtualHost>

<VirtualHost *:443>
        ServerName zabbix.sample.net

        SSLEngine on
        SSLCertificateFile      /etc/httpd/conf.d/lets.cert.pem
        SSLCertificateKeyFile   /etc/httpd/conf.d/lets.key.pem
        SSLCertificateChainFile /etc/httpd/conf.d/lets.chain.pem

        SSLProtocol     all -SSLv2 -SSLv3
        SSLCipherSuite  ALL

        DocumentRoot   /usr/share/zabbix/

        DirectoryIndex index.php

        Alias /.well-known/ /app/www/.well-known/
        <Directory /app/www/.well-known/>
                AllowOverride All
                Options FollowSymLinks Indexes
                Require all granted
        </Directory>

        <Directory />
                AllowOverride All
                Options FollowSymLinks Indexes
                Require all granted
        </Directory>
</VirtualHost>
' | sudo tee /etc/httpd/conf.d/zabbix.conf
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


zabbix client
-------------------

~~~
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

#### auto start
	sudo systemctl enable zabbix-agent
	sudo systemctl start zabbix-agent

