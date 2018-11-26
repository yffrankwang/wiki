### install
    sudo yum install -y php php-cli php-fpm php-gd php-mbstring php-mysql php-xml php-pdo php-opcache php-apcu php-intl php-pear php-curl


### install (php7)
    sudo yum install -y epel-release
    sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
    sudo yum install -y --enablerepo=remi,remi-php70 php php-devel php-mbstring php-pdo php-gd php-cli php-mysql php-pdo php-xml php-fpm php-opcache php-apcu php-intl php-pear php-curl

### EC2 (php7)
    sudo yum install php70 php70-devel php70-mbstring php70-pdo php70-gd php70-cli php70-mysqlnd php70-xml php70-fpm php70-opcache php70-apcu php70-intl php70-pear php70-curl

### EC2 (php7) (deprecated)
    sudo rpm -Uvh ftp://ftp.scientificlinux.org/linux/scientific/6.4/x86_64/updates/fastbugs/scl-utils-20120927-8.el6.x86_64.rpm
    sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
    sudo yum list | grep php70
    #sudo yum install --enablerepo=epel,remi,remi-php70 php70 php70-devel php70-mbstring php70-pdo php70-gd php70-cli php70-mysql php70-xml php70-fpm
    sudo yum install php70 php70-devel php70-mbstring php70-pdo php70-gd php70-cli php70-mysqlnd php70-xml php70-fpm php70-opcache php70-apcu php70-intl php70-pear php70-curl

### EC2 (php7) (deprecated)
    sudo rpm -Uvh https://mirror.webtatic.com/yum/el6/latest.rpm
    sudo yum install --enablerepo=webtatic-testing php70w php70w-devel php70w-fpm php70w-mysql php70w-mbstring php70w-pdo php70w-gd php70w-cli php70w-xml php70w-opcache php70w-apcu php70w-intl php70-pear php70-curl

### config php
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


### config php-fpm
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


### nginx permission
    sudo chown -R nginx.nginx /var/lib/php/session/
    sudo chown -R nginx.nginx /var/lib/php/7.0/


### auto start
    sudo chkconfig php-fpm on
    sudo service php-fpm start


### auto start (centos7)
    sudo systemctl enable php-fpm
    sudo systemctl start php-fpm
