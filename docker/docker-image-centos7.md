# docket centos7

## get image
```sh
docker pull centos:centos7
docker images
```

## run container
```sh
docker run -it -d --name centos7 centos:centos7
```

## run container with privileged
fix systemctl error: Failed to get D-Bus connection: Operation not permitted
```sh
docker run -it -d --privileged --name centos7 centos:centos7 /sbin/init
```

## list process
```sh
docker ps
```

## run bash
```sh
docker exec -it centos7 /bin/bash

yum install nano which openssh-clients
```

## stop container
```sh
docker stop centos7
```

## start container
```sh
docker start centos7
```

## delete container
```sh
docker rm centos7
```

## syslog
bash in docker
```sh
yum update -y
yum install -y rsyslog
echo '[ -f /usr/sbin/rsyslogd ] && /usr/sbin/rsyslogd' >> $HOME/.bash_profile

sed -i -e '/$ModLoad imjournal/s/^/#/' /etc/rsyslog.conf
sed -i -e 's/$OmitLocalLogging on/$OmitLocalLogging off/' /etc/rsyslog.conf
sed -i -e '/$IMJournalStateFile/s/^/#/' /etc/rsyslog.conf
sed -i -e '/$SystemLogSocketName/s/^/#/' /etc/rsyslog.d/listen.conf
```
