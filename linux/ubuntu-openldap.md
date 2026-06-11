# Ubuntu OpenLDAP

https://medium.com/analytics-vidhya/install-openldap-with-phpldapadmin-on-ubuntu-9e56e57f741e

## OpenLDAP
### install
```sh
sudo apt-get install slapd ldap-utils
sudo systemctl status slapd
```

### configuration
```sh
sudo dpkg-reconfigure slapd
sudo nano /etc/ldap/ldap.conf
```

```
BASE     dc=testldap,dc=com
URI      ldap://localhost
```

### confirm
```sh
sudo systemctl restart slapd
sudo slapcat
ldapsearch -x
```

### disable anonymous bind
```sh
echo 'dn: cn=config
changetype: modify
add: olcDisallows
olcDisallows: bind_anon' > /tmp/disable_bind_anon.ldif

sudo ldapadd -Y EXTERNAL -H ldapi:/// -f /tmp/disable_bind_anon.ldif
```

## php LDAP Admin

### install
```sh
sudo apt install phpldapadmin
```

### configuration
```sh
sudo nano /etc/phpldapadmin/config.php
```

```
$config->custom->appearance['timezone'] = 'Asia/Tokyo';
$servers->setValue('server','name','TestLdap LDAP Server');
$servers->setValue('server','host','ldap://127.0.0.1');
$servers->setValue('server','port',389);
$servers->setValue('login','anon_bind',true);
```


### browse
http://localhost/phpldapadmin

