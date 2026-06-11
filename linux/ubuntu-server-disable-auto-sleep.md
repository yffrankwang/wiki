
```sh
sudo -u gdm dbus-launch gsettings list-recursively org.gnome.settings-daemon.plugins.power
org.gnome.settings-daemon.plugins.power ambient-enabled true
org.gnome.settings-daemon.plugins.power idle-brightness 30
org.gnome.settings-daemon.plugins.power idle-dim true
org.gnome.settings-daemon.plugins.power lid-close-ac-action 'suspend'
org.gnome.settings-daemon.plugins.power lid-close-battery-action 'suspend'
org.gnome.settings-daemon.plugins.power lid-close-suspend-with-external-monitor false
org.gnome.settings-daemon.plugins.power power-button-action 'suspend'
org.gnome.settings-daemon.plugins.power power-saver-profile-on-low-battery true
org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 1200
org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing'
org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1200
org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'

sudo -u gdm dbus-launch gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type "'nothing'"
sudo -u gdm dbus-launch gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type "'nothing'"
```
