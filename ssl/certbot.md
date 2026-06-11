## ubuntu
https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04-ja

https://www.server-world.info/query?os=Ubuntu_22.04&p=ssl&f=2

```sh
sudo apt install certbot

sudo certbot certonly --webroot -w /var/www/html -d dns.srv.world
```

### apache
```sh
sudo apt install certbot python3-certbot-apache
sudo certbot --apache
sudo systemctl status certbot.timer
```

### nginx
```
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx
sudo systemctl status certbot.timer
```


## centos
```
sudo yum install python2-certbot-apache
sudo certbot --apache
```

## centos8
```
sudo yum install python3-certbot-apache
sudo certbot --apache
```


### test
```sh
sudo certbot renew --dry-run
```
