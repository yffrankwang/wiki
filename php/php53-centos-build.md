```sh
sudo yum -y install libxml2-devel.x86_64 \
  httpd-devel.x86_64 \
  openssl-devel.x86_64 \
  bzip2-devel.x86_64 \
  libcurl-devel.x86_64 \
  libjpeg-devel.x86_64 \
  libpng-devel.x86_64 \
  freetype-devel.x86_64 \
  libmcrypt-devel.x86_64 \
  libc-client-devel.x86_64 \
  mysql-devel 


./configure \
  --enable-cli \
  --enable-pdo \
  --enable-mbstring \
  --enable-mbregex \
  --enable-ftp \
  --enable-gd-native-ttf \
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
  --with-gd \
  --with-jpeg-dir \
  --with-png-dir \
  --with-freetype-dir \
  --with-ldap \
  --with-mcrypt \
  --with-xmlrpc \
  --with-imap \
  --with-imap-ssl \
  --with-kerberos \
  --with-libdir=lib64 \
  --with-config-file-path=/etc \
  --with-apxs2=/usr/sbin/apxs \
  --prefix=/usr/local/php53

make
sudo make install
```

