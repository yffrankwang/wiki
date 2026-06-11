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

## troubleshoot
Authentication is required to create a color managed device.

```sh
echo '
[Netowrkmanager]
Identity=unix-user:*
Action=org.freedesktop.color-manager.create-device
ResultAny=no
ResultInactive=no
ResultActive=yes
' | sudo tee /etc/polkit-1/localauthority/50-local.d/xrdp-color-manager.pkla
```
