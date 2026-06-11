# Apache
sudo apt install apache2
sudo systemctl enable apache2
 
sudo useradd apache
sudo sed -i -e 's/www-data/apache/g' /etc/apache2/envvars
