 CentOS7 XRDP
-------------------------------
https://www.hiroom2.com/2017/07/26/centos-7-xfce-en/
https://www.hiroom2.com/2017/10/01/centos-7-xrdp-xfce-en/

## xfce
```sh
sudo yum install -y epel-release
sudo yum groupinstall -y xfce
```

## xrdp
```sh
sudo yum install -y epel-release
sudo yum install -y xrdp
sudo sed -e 's/^new_cursors=true/new_cursors=false/g' -i /etc/xrdp/xrdp.ini
sudo systemctl enable xrdp
sudo systemctl start xrdp
```

### Open XRDP port
```sh
sudo firewall-cmd --add-port=3389/tcp --permanent
sudo firewall-cmd --reload
```

### Create ~/.Xclients
Create .Xclients in home directory of user to be connected.
```sh
echo xfce4-session > ~/.Xclients
chmod a+x ~/.Xclients
```

