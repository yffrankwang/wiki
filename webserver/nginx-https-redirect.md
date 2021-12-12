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
