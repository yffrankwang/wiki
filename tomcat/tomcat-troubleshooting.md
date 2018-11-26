### Unable to process Jar entry (javassist-3.20.0-GA.jar)
~~~
echo '
# fix: Unable to process Jar entry (javassist-3.20.0-GA.jar)
tomcat.util.scan.DefaultJarScanner.jarsToSkip=javassist-*.jar
' | sudo tee -a /etc/tomcat/catalina.properties
~~~

### WARNING: Failed to register in JMX: javax.naming.NamingException: 

Could not create resource factory instance [Root exception is java.lang.ClassNotFoundException: org.apache.tomcat.dbcp.dbcp.BasicDataSourceFactory]

> nano server.xml

~~~
  <Context ...
    <Resource 
      type="javax.sql.DataSource"
      factory="org.apache.commons.dbcp.BasicDataSourceFactory"
      ...
    />
  />
~~~

### Exception: Could not initialize class sun.awt.X11.XToolkit
java.lang.InternalError: Can't connect to X11 window server using 'localhost:10.0' as the value of the DISPLAY variable

> JAVA_OPTS="${JAVA_OPTS} -Djava.awt.headless=true"


### Tomcat behind reverse proxy

> nano server.xml

	<Valve className="org.apache.catalina.valves.RemoteIpValve"
		remoteIpHeader="x-forwarded-for"
		remoteIpProxiesHeader="x-forwarded-by"
		protocolHeader="x-forwarded-proto"
	/>
