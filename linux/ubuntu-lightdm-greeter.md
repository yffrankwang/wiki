## slick-greeter
### install
```sh
sudo apt-get update -y
sudo apt-get install -y slick-greeter lightdm-settings
```

### config
```sh
cat /usr/share/lightdm/lightdm.conf.d/50-slick-greeter.conf

sudo mv /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf \
        /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf.disabled

```

Settings / Login Window


## web-greeter
### install
```sh
sudo apt-get update
sudo apt-get install pyqt5-dev-tools
sudo apt-get install python3-whither
sudo apt-get install liblightdm-gobject-dev
sudo apt-get install python3-gi
git clone https://github.com/Antergos/web-greeter.git /tmp/greeter
cd /tmp/greeter
make install
```

### config
```sh
echo '[Seat:*]
greeter-session=web-greeter
' | sudo tee -a /usr/share/lightdm/lightdm.conf.d/60-lightdm-web-greeter.conf

sudo mv /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf \
        /usr/share/lightdm/lightdm.conf.d/60-lightdm-gtk-greeter.conf.disabled
```

Themes can be found at /usr/share/web-greeter/themes

Main Config file is at /etc/lightdm/web-greeter.yml

