## Monitor File Change
@see http://eng-manima.blogspot.jp/2014/10/linux-auditd.html
@see https://www.digitalocean.com/community/tutorials/how-to-use-the-linux-auditing-system-on-centos-7


### add settings
	# auditctl -a exit,never -F dir=/opt/apps/xxx/web/tmp -k exclude
	# auditctl -a exit,always -F dir=/opt/apps/xxx/web -F perm=wa -k xxxwa


### save settings
~~~
echo '
-a exit,never -F dir=/opt/apps/xxx/web/logo/_ -k exclude
-a exit,always -F dir=/opt/apps/xxx/web -F perm=wa -k xxxwa
' | tee -a /etc/audit/rules.d/audit.rules
~~~


### test
	# echo 'test' > /opt/apps/xxx/web/tmp/test.txt
	# tail /var/log/audit/audit.log


