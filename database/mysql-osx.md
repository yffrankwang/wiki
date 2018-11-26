### stop service
	echo PASSWORD | sudo -S /bin/launchctl unload /Library/LaunchDaemons/com.mysql.mysql.plist

### start service
	echo PASSWORD | sudo -S /bin/launchctl load /Library/LaunchDaemons/com.mysql.mysql.plist

