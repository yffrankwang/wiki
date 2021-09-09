### Basic Auth

```sh
sudo yum install httpd-tools
sudo a2enmod auth_digest
```

### Create Password File

sudo htdigest -c /etc/httpd/conf.d/htdigest "Digest Auth" <username>

	New password: password
	Re-type new password: password
	Adding password for user <username>


### Config

sudo nano /etc/httpd/conf.d/xxx.conf
	
~~~
	<Directory />
		AuthType Digest
		AuthName "Digest Auth"
		AuthUserFile  /etc/httpd/conf.d/htdigest
		Require valid-user
	</Directory>
~~~

~~~
	<Location />
		AuthType Digest
		AuthName "Digest Auth"
		AuthUserFile  /etc/httpd/conf.d/htdigest
		Require valid-user
	</Location>
~~~
