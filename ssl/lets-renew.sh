#!/bin/bash -ex

/root/letsencrypt/letsencrypt-auto renew --force-renew

cp /etc/letsencrypt/live/XXX/fullchain.pem /etc/nginx/conf.d/lets.crt
cp /etc/letsencrypt/live/XXX/privkey.pem   /etc/nginx/conf.d/lets.key

/bin/systemctl reload nginx

ls -l /etc/nginx/conf.d/ > /root/lets.log
openssl x509 -text -noout -in /etc/nginx/conf.d/lets.crt >> /root/lets.log
echo -n | openssl s_client -connect 127.0.0.1:443 >> /root/lets.log

/root/slack.sh \
 -u https://hooks.slack.com/services/XXXX \
 -n Lets -a /root/lets.log \
 "Succeeded to renew lets ssl"
