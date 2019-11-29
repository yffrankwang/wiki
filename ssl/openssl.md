 Checking Session Cache Using OpenSSL
--------------------------------------

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
