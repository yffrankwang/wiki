# Source download
```sh
wget https://www.php.net/distributions/php-7.4.19.tar.gz
tar xzvf php-7.4.19.tar.gz
```

# Centos 7.x
## Prepare
```sh
sudo yum -y install libxml2-devel \
  httpd-devel \
  openssl-devel \
  bzip2-devel \
  libcurl-devel \
  libjpeg-devel \
  libpng-devel \
  freetype-devel \
  libmcrypt-devel \
  libc-client-devel \
  libicu-devel \
  mysql-devel 
```

## Build
```sh
cd php-7.4.19

./configure \
  --enable-cli \
  --enable-pdo \
  --enable-mbstring \
  --enable-mbregex \
  --enable-ftp \
  --enable-sockets \
  --enable-maintainer-zts \
  --enable-intl \
  --enable-soap \
  --enable-zip \
  --with-pdo-pgsql \
  --with-pgsql \
  --with-pdo-mysql \
  --with-mysql \
  --with-curl \
  --with-openssl \
  --with-iconv \
  --with-bz2 \
  --with-zlib \
  --with-zip \
  --with-ldap \
  --with-mcrypt \
  --with-xmlrpc \
  --with-imap \
  --with-imap-ssl \
  --with-kerberos \
  --with-libdir=lib64 \
  --with-config-file-path=/etc \
  --with-apxs2=/usr/sbin/apxs \
  --prefix=/usr/local/php74

make
sudo make install
```

# CentOS 6.x

## krb5
```
No package 'krb5-gssapi' found
No package 'krb5' found
```
remove  --with-kerberos from configure

## sqlite3
```
Requested 'sqlite3 > 3.7.4' but version of SQLite is 3.6.20
```

```sh
wget https://www.sqlite.org/2021/sqlite-autoconf-3350500.tar.gz
cd sqlite-autoconf-3350500
./configure --prefix=/usr/local/lib/sqlite-3.35.5
make CFLAGS="-g -O2 -DSQLITE_ENABLE_COLUMN_METADATA"
sudo make install
```

## oniguruma
```sh
wget https://github.com/kkos/oniguruma/archive/v6.9.5.tar.gz
tar xvzf v6.9.5.tar.gz
cd oniguruma-6.9.5
autoreconf -vfi
./configure --prefix=/usr/local/lib/oniguruma-6.9.5
make
sudo make install
```

## libzip
```sh
wget https://libzip.org/download/libzip-1.7.3.tar.gz
tar xzvf libzip-1.7.3.tar.gz
cd libzip-1.7.3

```

## Build
```sh
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/sqlite-3.35.5/lib/pkgconfig"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/oniguruma-6.9.5/lib/pkgconfig"
export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/usr/local/lib/libzip-1.6.1/lib64/pkgconfig"

cd php-7.4.19

./configure \
  --enable-cli \
  --enable-pdo \
  --enable-mbstring \
  --enable-mbregex \
  --enable-ftp \
  --enable-sockets \
  --enable-maintainer-zts \
  --enable-soap \
  --with-pdo-pgsql \
  --with-pgsql \
  --with-pdo-mysql \
  --with-mysqli \
  --with-curl \
  --with-openssl \
  --with-iconv \
  --with-bz2 \
  --with-zlib \
  --with-zip \
  --with-ldap \
  --with-xmlrpc \
  --with-libdir=lib64 \
  --with-config-file-path=/etc \
  --with-apxs2=/usr/sbin/apxs \
  --prefix=/usr/local/php74

make
sudo make install
```

