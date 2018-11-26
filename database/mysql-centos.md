#### centos6
    sudo yum install mysql mysql-server
    sudo chkconfig mysqld on
    sudo service mysqld start

#### centos7
    sudo yum install mariadb-server mariadb
    sudo systemctl enable mariadb
    sudo systemctl start mariadb

#### config
    sudo nano /etc/my.cnf

after 5.5.3
~~~
[client]
default-character-set=utf8

[mysqld]
character-set-server=utf8
collation-server=utf8_general_ci
~~~

before 5.5.3
~~~
[client]
default-character-set=utf8

[mysqld]
default-character-set=utf8
character-set-server=utf8
collation-server=utf8_general_ci
~~~

performance config
~~~
[client]
port		= 3306
socket		= /var/lib/mysql/mysql.sock

[mysqld]
port		= 3306
socket		= /var/lib/mysql/mysql.sock
skip-external-locking
character-set-server = utf8
collation-server = utf8_general_ci
key_buffer_size = 32M
max_allowed_packet = 10M
table_open_cache = 128
sort_buffer_size = 2M
read_buffer_size = 2M
read_rnd_buffer_size = 8M
myisam_sort_buffer_size = 16M
thread_cache_size = 8
query_cache_size = 16M
default-storage-engine = InnoDB

log-bin = mysql-bin
expire_logs_day = 7

server-id = 1

[mysqldump]
quick
max_allowed_packet = 16M

[mysql]
no-auto-rehash

[myisamchk]
key_buffer_size = 32M
sort_buffer_size = 32M
read_buffer = 2M
write_buffer = 2M

[mysqlhotcopy]
interactive-timeout

~~~
