# Apache
sudo apt install apache2
sudo systemctl enable apache2
 
sudo useradd apache
sudo sed -i -e 's/www-data/apache/g' /etc/apache2/envvars

# SSL
sudo apt-get install -y mod_ssl
sudo a2enmod ssl

# modules
sudo a2enmod headers
sudo a2enmod rewrite
sudo a2enmod proxy
sudo a2enmod proxy_http

