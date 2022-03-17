# http -> https redirect
```
server {
	listen 80;
	server_name _;
	return 302 https://$http_host$request_uri;
}
```

# redirect behind a LoadBalancer
```
server {
	listen 80;
	server_name _;
	if ($http_x_forwarded_proto = "http") {
		return 302 https://$http_host$request_uri;
	}
}
```

# ssl config sample
```
	ssl_protocols        TLSv1 TLSv1.1 TLSv1.2;
	ssl_certificate      /etc/nginx/conf.d/self.crt.pem;
	ssl_certificate_key  /etc/nginx/conf.d/self.key.pem;

	ssl_session_cache    shared:SSL:1m;
	ssl_session_timeout  5m;

	ssl_ciphers  HIGH:!aNULL:!MD5;
	ssl_prefer_server_ciphers   on;
```