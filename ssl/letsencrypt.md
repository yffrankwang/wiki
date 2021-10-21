@see https://letsencrypt.com/usage/

## ubuntu
https://www.inmotionhosting.com/support/website/ssl/lets-encrypt-ssl-ubuntu-with-certbot/
```sh
sudo add-apt-repository ppa:certbot/certbot
sudo apt-get update
sudo apt-get install python3-certbot-apache
sudo certbot --apache -d domain.com -d www.domain.com
ls /etc/letsencrypt/live
```

To view settings on systemd:

	systemctl show certbot.timer

To view settings on non-systemd systems:

	cat /etc/cron.d/certbot

To test the renewal process to ensure it works:

	sudo certbot renew --dry-run


## CentOS7
```sh
sudo yum install -y epel-release
sudo yum install -y certbot
sudo certbot certonly --standalone -d www.letsencrypt.com
```


## CentOS
### install
	wget https://dl.eff.org/certbot-auto
	chmod a+x certbot-auto

### prepare
	./certbot-auto --help
	
### execute standalone
	./certbot-auto certonly -a standalone -d letsencrypt.com -d www.letsencrypt.com

### execute directory (".well-known" folder will be generated under WEB ROOT)
	./certbot-auto certonly -w /var/www/html -d letsencrypt.com -d www.letsencrypt.com

### execute directory (duplicate if /etc/letsencrypt/renewal/xxx.conf already exists)
	./certbot-auto --duplicate certonly -w /var/www/html -d letsencrypt.com -d www.letsencrypt.com

### confirm
	ll /etc/letsencrypt/live/letsencrypt.com/

### auto renew (every 2 month, day 1, AM 6:00)
	echo '0 6 1 2,4,6,8,10,12 * /root/certbot-auto renew --no-self-upgrade --force-renew && /bin/systemctl reload nginx' > lets.cron
	crontab lets.cron




### Amazon EC2
~~~
FATAL: Amazon Linux support is very experimental at present...
if you would like to work on improving it, please ensure you have backups
and then run this script again with the --debug flag!
Alternatively, you can install OS dependencies yourself and run this script
again with --no-bootstrap.
~~~

	./certbot-auto --debug

### Amazon EC2 Linux 2

	sudo wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/
	sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/Packages/e/epel-release-*.rpm
	sudo yum-config-manager --enable epel*
	sudo yum repolist all
	sudo yum install -y certbot

### Error: No module named cryptography

	sudo pip install -U pip virtualenv==15.1.0 cryptography
	sudo rm -rf /opt/eff.org/certbot/