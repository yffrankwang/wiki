### power management acpi (battery info)
```sh
sudo apt-get install acpi
```

http://linrunner.de/en/tlp/docs/tlp-linux-advanced-power-management.html
```sh
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
```

### thinkpad only
```sh
sudo apt-get install tp-smapi-dkms acpi-call-dkms

sudo mv /etc/default/tlp /tmp/tlp
sed \
  -e "s/#START_CHARGE_THRESH_BAT0=.*/START_CHARGE_THRESH_BAT0=85/" \
  -e "s/#STOP_CHARGE_THRESH_BAT0=.*/STOP_CHARGE_THRESH_BAT0=95/" \
  /tmp/tlp | sudo tee /etc/default/tlp
diff /tmp/tlp /etc/default/tlp
```


### adjust trackpoint sensitive
```sh
echo 'description "Trackpoint-Settings"
env TPDIR=/sys/devices/platform/i8042/serio1/serio2
start on virtual-filesystems
script
  while [ ! -f $TPDIR/sensitivity ]; do
    sleep 1
  done
  echo -n 255 > $TPDIR/sensitivity
  echo -n 128 > $TPDIR/speed
  echo -n 1 > $TPDIR/press_to_select
end script
' | sudo tee -a /etc/init/trackpoint.conf
```


### reduce touchpad sensitive
```sh
xinput list
xinput list-props "SynPS/2 Synaptics TouchPad"

echo '
#!/bin/sh

xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Noise Cancellation" 48 48
xinput set-prop "SynPS/2 Synaptics TouchPad" "Synaptics Finger" 50 60 50
' > ~/.xinputrc
```


### fingerprint
https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_5)

```sh
sudo add-apt-repository ppa:fingerprint/fingerprint-gui
sudo apt update
sudo apt install libbsapi policykit-1-fingerprint-gui fingerprint-gui

sudo apt install git libusb-1.0-0-dev libxv-dev
git clone https://github.com/nmikhailov/Validity90.git
cd Validity90/libfprint
./configure
make
make check
sudo make install
```
