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

```sh
sudo systemctl status xrdp
sudo systemctl start xrdp
sudo systemctl enable xrdp
```

## set xfce terminal
```sh
sudo update-alternatives --config x-terminal-emulator
```

## install packages
```sh
sudo apt install subversion git cmake openjdk-8-jdk maven
sudo apt install firefox geany doublecmd-gtk transmission-gtk handbrake mkvtoolnix-gui
```


