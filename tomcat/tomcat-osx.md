### stop service
	echo PASSWORD | sudo -S /bin/launchctl unload /Library/LaunchDaemons/org.apache.tomcat7.plist

### start service
	echo PASSWORD | sudo -S /bin/launchctl load /Library/LaunchDaemons/org.apache.tomcat7.plist

