 XRDP
-------------------------------
https://www.e-nekorakuen.net/?p=21815

## xfce
```sh
sudo apt install xfce4 xfce4-goodies
```

## xrdp
```sh
sudo apt install xrdp

echo xfce4-session > ~/.xsession
```

sudo nano /etc/xrdp/startwm.sh
```sh
##test -x /etc/X11/Xsession && exec /etc/X11/Xsession
##exec /bin/sh /etc/X11/Xsession

startxfce4
```

