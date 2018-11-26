#### systemd mysql won't stop

https://askubuntu.com/questions/615129/systemd-mysql-wont-stop

 - Make /etc/mysql/debian.cnf readable for the mysql user with

	sudo chgrp mysql /etc/mysql/debian.cnf
	sudo chmod 640 /etc/mysql/debian.cnf

 - Provide a slightly modified mysql.service file:

	sudo cp /lib/systemd/system/mysql.service /etc/systemd/system/
	sudo chmod 755 /etc/systemd/system/mysql.service

 - Provide an explicit stop command by opening the copied file in an editor:

	sudo nano /etc/systemd/system/mysql.service

 - and adding the following line under the [Service] section:

	ExecStop=/usr/bin/mysqladmin --defaults-file=/etc/mysql/debian.cnf shutdown

 - Make the new service file known to system:

	sudo systemctl daemon-reload
