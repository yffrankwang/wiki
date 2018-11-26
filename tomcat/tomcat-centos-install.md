### centos7
    sudo yum -y install java-1.7.0-openjdk-devel
    sudo yum -y install tomcat
    sudo systemctl enable tomcat
    sudo systemctl start tomcat

### mysql connector
    sudo yum -y install mysql-connector-java
    cd /usr/share/tomcat/lib/
    sudo ln -s /usr/share/java/mysql-connector-java.jar mysql-connector-java.jar

### Customize JAVA_OPTS
SEE HTTP://SERVERFAULT.COM/QUESTIONS/658502/TOMCAT-8-HANGS-ON-STARTUP-WHILE-DEPLOYING-WEBAPP-POSSIBLY-RELATED-TO-ENTROPY-GE

/etc/tomcat/tomcat.conf

	JAVA_OPTS="-Xms1024m -Xmx1536m -XX:MaxPermSize=128m -Djava.awt.headless=true -Djava.security.egd=file:/dev/urandom -Dorg.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH==true -Xloggc:/var/log/tomcat/gc.log -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=1048576"


# Customize /etc/tomcat7/server.xml
~~~
<Connector port="8080" protocol="HTTP/1.1"
           connectionTimeout="20000"
           URIEncoding="UTF-8"
           redirectPort="8443" />
<Connector port="8009" protocol="AJP/1.3"
           URIEncoding="UTF-8"
           redirectPort="8443" />
~~~
