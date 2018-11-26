## Postfix

### install postfix
    sudo yum -y install postfix

### install client
    sudo yum -y install mailx

### config postfix
    sudo nano /etc/postfix/main.cf

### start postfix
    # centos6
    sudo chkconfig postfix on
    sudo service postfix start

    # centos7
    sudo systemctl enable postfix
    sudo systemctl start postfix

### check listen port
    # centos6
    netstat -a | grep smtp

    # centos7
    ss -l | grep smtp

### troubleshooting

* IPv6 localhost(::1) problem, postfix failed like follows:
    systemd[1]: Starting Postfix Mail Transport Agent...
    aliasesdb[14420]: /usr/sbin/postconf: fatal: parameter inet_interfaces: no local ...r ::1
    aliasesdb[14420]: newaliases: fatal: parameter inet_interfaces: no local interfac...r ::1
    postfix[14432]: fatal: parameter inet_interfaces: no local interface found for ::1
    systemd[1]: postfix.service: control process exited, code=exited status=1
    systemd[1]: Failed to start Postfix Mail Transport Agent.


> sudo nano /etc/hosts
    # disable ipv6
    #::1         localhost


## SPF

### @see http://salt.iajapan.org/wpmu/anti_spam/admin/tech/explanation/spf/

    TXT "v=spf1 ip4:x.x.x.x ip4:y.y.y.y -all"


## DKIM

### @see  
  http://salt.iajapan.org/wpmu/anti_spam/admin/tech/explanation/dkim/
  https://blog.apar.jp/linux/856/

### install opendkim
    sudo yum -y install opendkim

### configuration
    sudo mkdir /etc/opendkim/keys/<domain>
    sudo opendkim-genkey -D /etc/opendkim/keys/<domain> -d <domain> -s <selector>
    sudo chown -R opendkim:opendkim /etc/opendkim/keys/*
    sudo cat /etc/opendkim/keys/<domain>/<selector>.txt

### DNS Record

    <selector>._domainkey.<domain>. IN  TXT "v=DKIM1; k=rsa; p=<PUBLIC KEY>"
    _adsp._domainkey.<domain>.  IN TXT "dkim=unknown"

### config  
    sudo cp /etc/opendkim.conf  /etc/opendkim.conf.org
    sed \
    -e 's/Mode.*v/Mode    sv/' \
    -e 's/KeyFile.*\/etc\/opendkim\/keys\/default.private/# KeyFile \/etc\/opendkim\/keys\/default.private/' \
    -e 's/# KeyTable.*\/etc\/opendkim\/KeyTable/KeyTable      \/etc\/opendkim\/KeyTable/' \
    -e 's/# SigningTable.*refile:\/etc\/opendkim\/SigningTable/SigningTable  refile:\/etc\/opendkim\/SigningTable/' \
    -e 's/# ExternalIgnoreList.*refile:\/etc\/opendkim\/TrustedHosts/ExternalIgnoreList    refile:\/etc\/opendkim\/TrustedHosts/' \
    -e 's/# InternalHosts.*refile:\/etc\/opendkim\/TrustedHosts/InternalHosts refile:\/etc\/opendkim\/TrustedHosts/' \
    /etc/opendkim.conf.org | sudo tee /etc/opendkim.conf
    diff /etc/opendkim.conf.org /etc/opendkim.conf 

    echo '<selector>._domainkey.<domain>     <domain>:<selector>:/etc/opendkim/keys/<domain>/<selector>.private' \
     | sudo tee -a /etc/opendkim/KeyTable

    echo '*@<domain>   <selector>._domainkey.<domain>' \
     | sudo tee -a /etc/opendkim/SigningTable

    echo 'x.x.x.x/32' | sudo tee -a /etc/opendkim/TrustedHosts

### start

    # centos6
    sudo service opendkim start
    sudo chkconfig opendkim on

    # centos7
    sudo systemctl start opendkim
    sudo systemctl enable opendkim


## Postfix & DKIM

~~~
    echo ' 
#
# DKIM
#
smtpd_milters = inet:127.0.0.1:8891
non_smtpd_milters = $smtpd_milters
milter_default_action = accept
' | sudo tee -a /etc/postfix/main.cf
~~~

    sudo service postfix reload

    sudo systemctl reload postfix
