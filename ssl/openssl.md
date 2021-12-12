## Send Continus Request

~~~
openssl s_client -crlf -connect www.example.com:443 -servername www.example.com <<EOF
GET / HTTP/1.1
Host: www.example.com
User-Agent: openssl
Accept: */*

GET / HTTP/1.1
Host: www2.example.com
User-Agent: openssl
Accept: */*

EOF
~~~



## Checking Session Cache Using OpenSSL

### Request #1

> openssl s_client -crlf -connect 127.0.0.1:443  -servername site1.com -reconnect -no_ticket -sess_out sess.tmp

~~~
HEAD / HTTP/1.1
User-Agent: openssl
Accept: */*
Host: site1.com

~~~


### Request #2

> openssl s_client -crlf -connect 127.0.0.1:443  -servername site2.com -reconnect -no_ticket -sess_in sess.tmp

~~~
HEAD / HTTP/1.1
User-Agent: openssl
Accept: */*
Host: site2.com

~~~


## change the password of a pfx file

### convert use openssl

> openssl pkcs12 -nodes  -in old.pfx -out old.pem
> openssl pkcs12 -export -in old.pem -out new.pfx


### check pfx under windows

> certutil -dump new.pfx
