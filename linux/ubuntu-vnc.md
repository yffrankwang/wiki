 VNC
-------------------------------

### vnc4server
	# Note: Try using Ctrl-I instead of Tab on VncViewer Terminal

	sudo apt-get install vnc4server

### start vncserver
	vncserver

~~~
cp ~/.vnc/xstartup ~/.vnc/xstartup.bak
echo "
#!/bin/sh
unset SESSION_MANAGER
unset DBUS_SESSION_BUS_ADDRESS

startxfce4 &

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
#vncconfig -iconic &

" > ~/.vnc/xstartup
~~~

### kill vncserver
	vncserver -kill :1


### vnc4server init.d
~~~
sudo cp vncserver.init.sh /etc/init.d/vncserver
sudo chmod +x /etc/init.d/vncserver
sudo mkdir -p /etc/vncserver
echo "
VNCSERVERS=\"1:vncuser\"
VNCSERVERARGS[1]=\"-geometry 1280x800\"
" | sudo tee /etc/vncserver/vncservers.conf
sudo update-rc.d vncserver defaults 99
~~~

### x11vnc
~~~
sudo apt-get install x11vnc xinetd
echo "
service x11vnc
{
    type = UNLISTED
    disable = no
    socket_type = stream
    protocol = tcp
    wait = no
    user = root
    server = /usr/bin/x11vnc
    server_args = -inetd -o /var/log/x11vnc.log -display :0 -forever -bg -rfbauth /etc/x11vnc/passwd -shared -enablehttpproxy -forever -nolookup -auth /var/run/lightdm/root/:0
    port = 5900
    flags = IPv6
}
" | sudo tee /etc/xinetd.d/x11vnc

sudo mkdir /etc/x11vnc
sudo x11vnc -storepasswd /etc/x11vnc/passwd
sudo service xinetd restart
~~~
