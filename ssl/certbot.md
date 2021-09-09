## ubuntu
https://www.digitalocean.com/community/tutorials/how-to-secure-apache-with-let-s-encrypt-on-ubuntu-20-04-ja

```sh
sudo certbot --apache

sudo systemctl status certbot.timer

```

### test
```sh
sudo certbot renew --dry-run
```
