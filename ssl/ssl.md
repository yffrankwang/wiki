General OpenSSL Commands
==================================

These commands allow you to generate CSRs, Certificates, Private Keys and do other miscellaneous tasks.

* Generate a new private key and Certificate Signing Request
	openssl req -out CSR.csr -new -newkey rsa:2048 -nodes -keyout key.pem

* Generate a self-signed certificate (see How to Create and Install an Apache Self Signed Certificate for more info)
	openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout key.pem -out cert.pem

* Generate a certificate signing request (CSR) for an existing private key
	openssl req -out CSR.csr -key key.pem -new

* Generate a certificate signing request based on an existing certificate
	openssl x509 -x509toreq -in cert.pem -out CSR.csr -signkey key.pem

* Remove a passphrase from a private key
	openssl rsa -in key.pem -out new.key.pem


Checking Using OpenSSL
--------------------------

If you need to check the information within a Certificate, CSR or Private Key, use these commands. You can also check CSRs and check certificates using our online tools.

* Check a Certificate Signing Request (CSR)
	openssl req -text -noout -verify -in CSR.csr

* Check a private key
	openssl rsa -in key.pem -check

* Check a certificate
	openssl x509 -in cert.pem -text -noout

* Check a PKCS#12 file (.pfx or .p12)
	openssl pkcs12 -info -in keystore.p12


Debugging Using OpenSSL
-------------------------------
If you are receiving an error that the private doesn't match the certificate or that a certificate that you installed to a site is not trusted, try one of these commands. If you are trying to verify that an SSL certificate is installed correctly, be sure to check out the SSL Checker.

* Check an MD5 hash of the public key to ensure that it matches with what is in a CSR or private key
	openssl x509 -noout -modulus -in cert.pem | openssl md5
	openssl rsa  -noout -modulus -in key.pem | openssl md5
	openssl req  -noout -modulus -in CSR.csr | openssl md5

* Check an SSL connection. All the certificates (including Intermediates) should be displayed
	openssl s_client -connect www.paypal.com:443

	
Converting Using OpenSSL
--------------------------------
These commands allow you to convert certificates and keys to different formats to make them compatible with specific types of servers or software. For example, you can convert a normal PEM file that would work with Apache to a PFX (PKCS#12) file and use it with Tomcat or IIS. Use our SSL Converter to convert certificates without messing with OpenSSL.

* Convert a DER file (.crt .cer .der) to PEM
	openssl x509 -inform der -in cert.der -out cert.pem

* Convert a PEM file to DER
	openssl x509 -outform der -in cert.pem -out cert.der

* Convert a PKCS#12 file (.pfx .p12) containing a private key and certificates to PEM
  You can add -nocerts to only output the private key or add -nokeys to only output the certificates.
	openssl pkcs12 -in keyStore.pfx -out keyStore.pem -nodes


* Convert a PEM certificate file and a private key to PKCS#12 (.pfx .p12)
	openssl pkcs12 -export -out certificate.pfx -inkey key.pem -in cert.pem -certfile CACert.crt



### create key, input password: pass
	openssl genrsa -des3 -out key.des3.pem 2048
	openssl genrsa -des3 -out key.des3.pem 2048 -sha256


### create csr
	openssl req -new -key key.des3.pem -out CSR.csr
	openssl req -new -sha256 -key key.des3.pem -out CSR.csr

~~~
-----
Country Name (2 letter code) [XX]:JP
State or Province Name (full name) []:Tokyo
Locality Name (eg, city) [Default City]:Chiyoda-ku
Organization Name (eg, company) [Default Company Ltd]:XXX Co.,Ltd
Organizational Unit Name (eg, section) []:YYY
Common Name (eg, your name or your server hostname) []:*.xxx.yyy
Email Address []:

Please enter the following 'extra' attributes
to be sent with your certificate request
A challenge password []:
An optional company name []:
-----
~~~

### remove the pass phrase on an RSA private key:
@see https://www.openssl.org/docs/apps/rsa.html

	openssl rsa -in key.des3.pem -out key.pem


### Generating a Self-Signed Certificate
	openssl x509 -req -days 365 -in CSR.csr -signkey key.pem -out cert.pem
	openssl x509 -req -days 365 -in CSR.csr -signkey key.pem -out cert.pem -sha256


### print pfx cert
	keytool -v -list -storetype pkcs12 -keystore keystore.pfx

### print pem
	openssl x509 -text -in cert.pem


### print key
	openssl rsa -in key.pem -outform PEM


### convert key (-BEGIN RSA PRIVATE KEY- --> -BEGIN PRIVATE KEY-)
	openssl pkcs8 -topk8 -inform pem -in file.key -outform pem -nocrypt -out file.pem


### check key
	openssl rsa -in key.pem -check


### decode key
	openssl rsa -in key.des3.pem  -out key.pem


### encode key
	openssl rsa -in key.pem -des3 -out key.des3.pem


### extract key from pfx(pkcs12)
	openssl pkcs12 -in keystore.pfx -nocerts -out key.pem


### convert pem to pfx
	openssl pkcs12 -export -out keystore.pfx -inkey key.pem -in cert.pem


### combine server.pem + intermediate.pem
	> For example, suppose you created a certificate in EFT Server called "mycert.crt" (and it has the associated private key "mycert.key"), 
	> then sent the CSR file ("mycert.csr") to Verisign, who sent you the following:
	>
	>   Signed certificate ("mycert_Signed.crt")
	>   Intermediate certificate ("Verisign_Intermediate.crt")
	>   Root certificate ("Verisign_Root.crt").
	>
	> To combine these into a single file that EFT Server supports, use the following commands in OpenSSL:

	openssl x509 -inform PEM -in "mycert_Signed.crt" -text > fullcert.pem
	openssl x509 -inform PEM -in "Verisign_Intermediate.crt" -text >> fullcert.pem
	openssl x509 -inform PEM -in "Verisign_Root.crt" -text >> fullcert.pem


### convert pfx to jks
	keytool -importkeystore \
			-srcstoretype pkcs12 -srckeystore  <source.pfx> -srcstorepass  <PASSWORD_PFX> -srcalias  [ALIAS_SRC] \
			-deststoretype jks   -destkeystore <target.jks> -deststorepass <PASSWORD_JKS> -destalias [ALIAS_DEST]

### print alias
	keytool -list -storetype pkcs12 -keystore keystore.pfx -v | grep Alias

	keytool -importkeystore \
	 -srcstoretype  pkcs12  -srckeystore  keystore.pfx  -srcstorepass  SRC_PASS \
	 -deststoretype jks     -destkeystore keystore.jks  -deststorepass DES_PASS

	keytool -importkeystore -srcstoretype  pkcs12  -srckeystore  keystore.pfx  -deststoretype jks  -destkeystore keystore.jks

### print jks cert
	keytool -list -v -keystore keystore.jks


### PKCS#7
	openssl pkcs7 -print_certs -in cert.p7b
	openssl pkcs7 -print_certs -in cert.p7b -out cert.pem

### CRL
	openssl crl -inform DER -text -noout -in my.crl

### print ciphers
	openssl ciphers -V 'ALL'

### connect test
	echo -n | openssl s_client -connect www.google.com:443
	echo B | openssl s_client -ssl3 -connect www.google.com:443

### send http request
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
