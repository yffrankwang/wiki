# install httpd
#
sudo yum -y install httpd subversion mod_dav_svn

sudo cp /etc/httpd/conf/httpd.conf /etc/httpd/conf/httpd.conf.org
sed \
-e "s/#NameVirtualHost \\*:80/NameVirtualHost \\*:80/" \
-e "s/ErrorLog logs\/error_log/ErrorLog \/var\/www\/log\/httpd\/httpd.error.log/" \
-e "s/CustomLog logs\\/access_log combined/CustomLog \"\|\/usr\/sbin\/rotatelogs \/var\/www\/log\/httpd\/httpd.access.log-%Y%m%d 86400 540\" combined/" \
/etc/httpd/conf/httpd.conf.org | sudo tee /etc/httpd/conf/httpd.conf


sudo usermod -a -G apache tomcat
sudo usermod -a -G apache nginx
sudo usermod -a -G tomcat apache
sudo usermod -a -G nginx apache

sudo mkdir -p /var/www/log/httpd
sudo chown -R apache:apache /var/www
sudo chmod -R ug+rwX /var/www


###########################################
# tomcat
#

echo "
<VirtualHost *:80>
    ServerName jenkins.xxx.com
    ServerAlias jenkins
    DocumentRoot /opt/apps/jenkins/ROOT
    ErrorLog   /var/log/httpd/jenkins.error.log
    CustomLog \"|/usr/sbin/rotatelogs /var/log/httpd/jenkins.access.log-%Y%m%d 86400 540\" combined
    AllowEncodedSlashes NoDecode
    ProxyRequests Off
    ProxyPass         /  ajp://localhost:8009/  nocanon
    ProxyPassReverse  /  ajp://localhost:8089/
</VirtualHost>

" | sudo tee /etc/httpd/conf.d/tomcat.conf


###########################################
# PHP
#

echo "
<VirtualHost *:80>
    ServerName foobar.com
    DocumentRoot /var/apps/foobar/
    ErrorLog   /var/log/httpd/foobar.error.log
    CustomLog \"|/usr/sbin/rotatelogs /var/log/httpd/foobar.access.log-%Y%m%d 86400 540\" combined
    <Directory /var/www/apps/foobar/>
        Options FollowSymLinks
        AllowOverride All
    </Directory>
</VirtualHost>
" | sudo tee -a /etc/httpd/conf.d/php.conf



###########################################
# start
#
sudo chkconfig httpd on
sudo service httpd start


