	CentOS7 Xfce VNC Server
=============================

## Install

	yum groupinstall Xfce
	yum install tigervnc-server


## Password

	vncpasswd
		Password:
		Verify:


## config

	cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service

Replace <USER> with your username
~~~
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target
 
[Service]
Type=forking
 
# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
ExecStart=/usr/sbin/runuser -l <USER> -c "/usr/bin/vncserver %i"
PIDFile=/home/<USER>/.vnc/%H%i.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill %i > /dev/null 2>&1 || :'
 
[Install]
WantedBy=multi-user.target
~~~~

Repace ExecStart:
	ExecStart=/usr/sbin/runuser -l <USER> -c "/usr/bin/vncserver %i -geometry 1366x768"


## Start

	vncserver -geometry 1600x900 :1

## Stop

	vncserver -kill :1

## change xstartup

	nano ~/.vnc/xstartup

~~~
#!/bin/sh

#unset SESSION_MANAGER
#unset DBUS_SESSION_BUS_ADDRESS
#/etc/X11/xinit/xinitrc
#vncserver -kill $DISPLAY

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
#x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &
exec xfce4-session &
~~~

## Auto start

	systemctl enable vncserver@:1.service


## Firewall

	firewall-cmd --permanent --add-service=vnc-server
	firewall-cmd --reload
	firewall-cmd --list-all


## Fonts

	yum groupinstall fonts

