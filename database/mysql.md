#### user
```sql
CREATE USER 'user'@'%' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON dbname-xxxx.* TO 'user'@'%';
GRANT ALL PRIVILEGES ON dbname-xxxx.* TO 'user'@'%' IDENTIFIED BY 'password';
ALTER USER 'user'@'%' PASSWORD EXPIRE NEVER;
FLUSH PRIVILEGES;
```

#### database
```sql
create database <dbname> default character set utf8 collate utf8_general_ci;
ALTER SCHEMA <dbname>  DEFAULT COLLATE utf8_general_ci;
```

#### dump
```sh
mysqldump -hlocalhost -uuser -ppass dbname | gzip > dbname.sql.tgz
mysqldump --no-data -hlocalhost -uuser -ppass dbname > dbname.schema.sql
```

#### select table rows
```sql
SELECT table_name, table_rows FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'schema';
```

### disable/enable foreign key check
```sql
SET foreign_key_checks = 0;
SET foreign_key_checks = 1;
```

### pipe as concat
```sql
SET sql_mode='PIPES_AS_CONCAT';
```

### max allowed packet
mysql> show variables like 'max_allowed_packet';
~~~
+--------------------+---------+
| Variable_name      | Value   |
+--------------------+---------+
| max_allowed_packet | 1048576 |
+--------------------+---------+
~~~

change settings of my.cnf:
~~~
[mysqld]
max_allowed_packet=16MB
innodb_file_per_table=1
~~~

### disable bin log
```sql
SHOW MASTER LOGS;
PURGE MASTER LOGS before now();
```

my.cnf> disable-log-bin


### “Incorrect string value” when trying to insert UTF-8 into MySQL via JDBC?
http://stackoverflow.com/questions/10957238/incorrect-string-value-when-trying-to-insert-utf-8-into-mysql-via-jdbc

MySQL's utf8 permits only the Unicode characters that can be represented with 3 bytes in UTF-8. Here you have a character that needs 4 bytes: \xF0\x90\x8D\x83 [(U+10343 GOTHIC LETTER SAUIL)](http://www.fileformat.info/info/unicode/char/10343/index.htm).

If you have MySQL 5.5 or later you can change the column encoding from utf8 to [utf8mb4](http://dev.mysql.com/doc/refman/5.5/en/charset-unicode-utf8mb4.html). This encoding allows storage of characters that occupy 4 bytes in UTF-8.

You may also have to set the server property character_encoding_server to utf8mb4 in the MySQL configuration file. It seems that [Connector/J defaults to 3-byte Unicode otherwise](http://dev.mysql.com/doc/connector-j/en/connector-j-reference-charsets.html):

For example, to use 4-byte UTF-8 character sets with Connector/J, configure the MySQL server with character_set_server=utf8mb4, and leave characterEncoding out of the Connector/J connection string. Connector/J will then autodetect the UTF-8 setting.
