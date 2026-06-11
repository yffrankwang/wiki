### timezone
> sudo cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime
> sudo nano /etc/sysconfig/clock

	ZONE="Asia/Tokyo"


### hostname
> sudo nano /etc/sysconfig/network

    HOSTNAME=xxx


### fonts
CentOS 7/8
```sh
yum group install -y Fonts
```

CentOS 6
```sh
yum groupinstall -y "Japanese Support"
yum groupinstall -y "Korean Support"
yum groupinstall -y "Hindi Support"
yum groupinstall -y "Kannada Support"
```
