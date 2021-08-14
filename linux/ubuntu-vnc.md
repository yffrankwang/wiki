 VNC
-------------------------------

## xfce
```sh
sudo apt install xfce4 xfce4-goodies
```

## tigervnc
https://tutorialcrawler.com/ubuntu-debian/ubuntu-20-04%E3%81%ABvnc%E3%82%B5%E3%83%BC%E3%83%90%E3%83%BC%E3%82%92%E3%82%A4%E3%83%B3%E3%82%B9%E3%83%88%E3%83%BC%E3%83%AB%E3%81%99%E3%82%8B%E6%96%B9%E6%B3%95/

```sh
sudo apt install tigervnc-standalone-server

echo "
exec startxfce4
" >> ~/.vnc/xstartup

chmod +x ~/.vnc/xstartup
```

### start vncserver
```sh
	vncserver -localhost no -geometry 1600x900 :1
```

### kill vncserver
```sh
	vncserver -kill :1
```

### change password
```sh
	vncpasswd
```

### setup autorun
```sh
echo '
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=simple
User=ubuntu
PAMName=login
PIDFile=/home/%u/.vnc/%H%i.pid
ExecStartPre=/usr/bin/vncserver -kill :%i > /dev/null 2>&1 || :
ExecStart=/usr/bin/vncserver :%i -localhost no -geometry 1600x900
ExecStop=/usr/bin/vncserver -kill :%i

[Install]
WantedBy=multi-user.target
' | sudo tee /etc/systemd/system/vncserver@.service

sudo systemctl daemon-reload
sudo systemctl enable vncserver@1.service
sudo systemctl start vncserver@1.service 
```

## tightvnc
https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-vnc-on-ubuntu-20-04
https://linuxize.com/post/how-to-install-and-configure-vnc-on-ubuntu-20-04/

```sh
sudo apt install tightvncserver

echo "
exec startxfce4
" >> ~/.vnc/xstartup

chmod +x ~/.vnc/xstartup
```


### start vncserver
```sh
	vncserver -geometry 1600x900 :1
```

### kill vncserver
```sh
	vncserver -kill :1
```

### change password
```sh
	vncpasswd
```

### setup autorun
https://serverspace.io/support/help/install-tightvnc-server-on-ubuntu-20-04/

