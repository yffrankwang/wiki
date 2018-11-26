### Basic Auth

> sudo yum install httpd-tools


### Create Password File

sudo htpasswd -c /etc/nginx/htpasswd <username>

	New password: password
	Re-type new password: password
	Adding password for user <username>


### Config

sudo nano /etc/nginx/nginx.conf
	
~~~
server {
    ...

    location / {
        # Basic auth
        auth_basic "Restricted";
        auth_basic_user_file /etc/nginx/htpasswd;
    }
}
~~~
