# Install OpenJDK
Tomcat 9 requires Java SE 8 or later. In this tutorial we will install OpenJDK, the open source implementation of the Java Platform which is the default Java development and runtime in CentOS 7.

Install the OpenJDK by typing the following command:

	sudo yum install java-1.8.0-openjdk-devel


# Create Tomcat system user
Running Tomcat as the root user is a security risk and not considered best practice.

We’ll create a new system user and group with home directory /opt/tomcat that will run the Tomcat service:

	sudo useradd -m -U -d /opt/tomcat -s /bin/false tomcat


# Download Tomcat
We will download the latest version of Tomcat 9.0.x from the Tomcat downloads page.

	wget https://www-us.apache.org/dist/tomcat/tomcat-9/v9.0.14/bin/apache-tomcat-9.0.14.tar.gz

When the download is complete, extract the tar file:

	tar -xf apache-tomcat-9.*.tar.gz

Move the Tomcat source files to it to the /opt/ directory:

	sudo mv apache-tomcat-9.0.14 /opt/

Tomcat 9 is updated frequently. To have more control over versions and updates, we will create a symbolic link latest which will point to the Tomcat installation directory:

	cd /opt/
	sudo ln -s apache-tomcat-9.0.13 tomcat9

The tomcat user that we previously set up needs to have access to the tomcat installation directory.
Run the following command to change the directory ownership to user and group tomcat:

	sudo chown -R tomcat:tomcat *tomcat*

Make the scripts inside the bin directory executable:

	sudo chmod -R g+rwX tomcat9
	sudo chmod +x ./tomcat9/bin/*.sh

# Create a systemd unit file
To make Tomcat run as a service open your text editor and create a tomcat.service unit file in the /etc/systemd/system/ directory:

~~~
echo '
[Unit]
Description=Tomcat 9 servlet container
After=network.target

[Service]
Type=forking

User=tomcat
Group=tomcat

Environment="JAVA_HOME=/usr/lib/jvm/jre"
Environment="JAVA_OPTS=-Djava.security.egd=file:///dev/urandom"

Environment="CATALINA_BASE=/opt/tomcat9"
Environment="CATALINA_HOME=/opt/tomcat9"
Environment="CATALINA_PID=/opt/tomcat9/temp/tomcat.pid"
Environment="CATALINA_OPTS=-Xms512M -Xmx2048M -server -Xloggc:/opt/tomcat9/logs/gc.log -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -XX:+UseGCLogFileRotation -XX:NumberOfGCLogFiles=10 -XX:GCLogFileSize=1048576"

ExecStart=/opt/tomcat9/bin/startup.sh
ExecStop=/opt/tomcat9/bin/shutdown.sh

[Install]
WantedBy=multi-user.target
' | sudo tee /etc/systemd/system/tomcat9.service
~~~

Notify systemd that we created a new unit file by typing:

	sudo systemctl daemon-reload

Enable and start the Tomcat service:

	sudo systemctl enable tomcat9
	sudo systemctl start tomcat9
