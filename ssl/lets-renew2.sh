#!/bin/bash -x

## yum install expect

cd /etc/nginx/conf.d/
mv lets.crt.pem lets.crt.pem.old
mv lets.key.pem lets.key.pem.old

expect -c '
set timeout 5
spawn sftp root@xxxx
expect "password:"
send "XXXXX\n"
expect "sftp>"
send "cd /etc/nginx/conf.d/\n"
expect "sftp>"
send "get lets.crt.pem\n"
expect "sftp>"
send "get lets.key.pem\n"
expect "sftp>"
send "bye\n"
interact
exit 0
'

ERR="Failed to get lets ssl from xxxx"
if [ -e lets.crt.pem ] && [ -e lets.key.pem ]; then
  ERR="Succeeded to get lets ssl from xxxx"
  systemctl reload nginx
fi

ls -l > /root/lets.log
openssl x509 -text -noout -in /etc/nginx/conf.d/lets.crt >> /root/lets.log
echo -n | openssl s_client -connect 127.0.0.1:443 >> /root/lets.log

/root/slack.sh \
 -u https://hooks.slack.com/services/XXXX \
 -n Lets -a /root/lets.log \
 "$ERR"
