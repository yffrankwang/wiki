@see https://letsencrypt.jp/usage/

### install
	wget https://dl.eff.org/certbot-auto
	chmod a+x certbot-auto

### prepare
	./certbot-auto --help
	
### execute standalone
	./certbot-auto certonly -a standalone -d letsencrypt.jp -d www.letsencrypt.jp

### execute directory (".well-known" folder will be generated under WEB ROOT)
	./certbot-auto certonly -w /var/www/html -d letsencrypt.jp -d www.letsencrypt.jp

### execute directory (duplicate if /etc/letsencrypt/renewal/xxx.conf already exists)
	./certbot-auto --duplicate certonly -w /var/www/html -d letsencrypt.jp -d www.letsencrypt.jp

### confirm
	ll /etc/letsencrypt/live/letsencrypt.jp/

### auto renew (every 2 month, day 1, AM 6:00)
	echo '0 6 1 2,4,6,8,10,12 * /root/certbot-auto renew --force-renew && /bin/systemctl reload nginx' > lets.cron
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
	
