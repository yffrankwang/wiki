### install
```sh
sudo yum install -y php php-cli php-fpm php-gd php-mbstring php-mysql php-xml php-pdo php-opcache php-apcu php-intl php-pear php-curl
```

### install (php7)
```sh
sudo yum install -y epel-release
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
sudo yum install php74 php74-php php74-php-pgsql php74-php-soap php74-php-xml php74-php-mbstring php74-php-intl
cat /etc/httpd/conf.modules.d/15-php74-php.conf
```

### config php
```sh
sudo cp /etc/php.ini /etc/php.ini.org
sed \
-e 's/error_log = syslog/;error_log = syslog/' \
-e 's/;error_log = php_errors.log/error_log = \/var\/log\/php_errors.log/' \
-e 's/post_max_size = .*/post_max_size = 16M/' \
-e 's/upload_max_filesize = .*/upload_max_filesize = 10M/' \
-e 's/max_execution_time = .*/max_execution_time = 300/' \
-e 's/max_input_time = .*/max_input_time = 300/' \
-e 's/;date.timezone = .*/date.timezone = Asis\/Tokyo/' \
/etc/php.ini.org | sudo tee /etc/php.ini
diff /etc/php.ini.org /etc/php.ini 
```

### config php-fpm
```sh
sudo cp /etc/php-fpm.d/www.conf  /etc/php-fpm.d/www.conf.org
sed \
-e 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php-fpm\/php-fpm.sock/' \
-e 's/user = apache/user = nginx/' \
-e 's/group = apache/group = nginx/' \
-e 's/;listen.owner = nobody/listen.owner = nginx/' \
-e 's/;listen.group = nobody/listen.group = nginx/' \
-e 's/;listen.mode = 0666/listen.mode = 0666/' \
-e 's/pm.max_children = .*/pm.max_children = 5/' \
-e 's/pm.start_servers = .*/pm.start_servers = 1/' \
-e 's/pm.min_spare_servers = .*/pm.min_spare_servers = 1/' \
-e 's/pm.max_spare_servers = .*/pm.max_spare_servers = 2/' \
-e 's/;pm.max_requests = .*/pm.max_requests = 50000/' \
-e 's/;request_terminate_timeout = .*/request_terminate_timeout = 300s/' \
-e 's/;request_slowlog_timeout = .*/request_slowlog_timeout = 60s/' \
-e 's/;catch_workers_output = .*/catch_workers_output = yes/' \
-e 's/;php_flag\[display_errors\] = .*/php_flag\[display_errors\] = on/' \
-e 's/;php_admin_value\[memory_limit\] = .*/php_admin_value\[memory_limit\] = 128M/' \
/etc/php-fpm.d/www.conf.org | sudo tee /etc/php-fpm.d/www.conf
diff /etc/php-fpm.d/www.conf.org /etc/php-fpm.d/www.conf
```

### nginx permission
```sh
sudo chown -R nginx.nginx /var/lib/php/session/
sudo chown -R nginx.nginx /var/lib/php/7.0/
```

### auto start
```sh
sudo chkconfig php-fpm on
sudo service php-fpm start
```

### auto start (centos7)
```sh
sudo systemctl enable php-fpm
sudo systemctl start php-fpm
```
