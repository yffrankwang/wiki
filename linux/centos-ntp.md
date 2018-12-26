# install NTPd 

	sudo yum -y install ntp

# config ntpd

	sudo nano /etc/ntp.conf

	server ntp.nict.jp iburst
	server ntp1.jst.mfeed.ad.jp iburst
	server ntp2.jst.mfeed.ad.jp iburst 

# start ntpd

	systemctl start ntpd 
	systemctl enable ntpd 
