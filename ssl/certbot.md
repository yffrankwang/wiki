## ubuntu
https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04-ja

https://www.server-world.info/query?os=Ubuntu_22.04&p=ssl&f=2

### install
ubuntu
```sh
sudo apt install certbot python3-certbot-apache python3-certbot-nginx
```

centos
```
sudo yum install python3-certbot-apache
```


### dns
```sh
sudo apt-get install dnsutils
sudo certbot certonly --preferred-challenges dns --manual -d *.example.com

dig -t TXT _acme-challenge.example.com +trace

sudo certbot renew
sudo certbot renew --force-renewal
```

### webroot
```sh
sudo certbot certonly --webroot -w /var/www/html -d dns.srv.world
```

### apache
```sh
sudo certbot --apache --no-redirect
sudo certbot reconfigure --nginx --no-redirect
sudo systemctl status certbot.timer
```

### nginx
```
sudo certbot --nginx --no-redirect
sudo certbot reconfigure --nginx --no-redirect
sudo systemctl status certbot.timer
```

### list
```
sudo certbot certificates
```

### delete
```
sudo certbot delete --cert-name [証明書名]
```




### test
```sh
sudo certbot renew --dry-run
```
