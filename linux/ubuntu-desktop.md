### timezone
```sh
sudo timedatectl set-timezone Asia/Tokyo
```

### shortcut location
```sh
cd /usr/share/applications
```

### lightdm background location
```sh
cd /usr/share/backgrounds
```

### system clock
> @see https://help.ubuntu.com/community/UbuntuTime
> UTC=yes

```sh
sudo sed -i 's/UTC=no/UTC=yes/' /etc/default/rcS
timedatectl set-local-rtc 0 --adjust-system-clock
```

### grub-customizer
```sh
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt update
sudo apt install grub-customizer
```

### boot-repair
```sh
sudo add-apt-repository ppa:yannubuntu/boot-repair
sudo apt update
sudo apt install boot-repair boot-info
```

### dir location settings
> XDG_DESKTOP_DIR="$HOME/Desktop"

```sh
cat ~/.config/user-dirs.dirs
```

### update
```sh
sudo apt update
sudo apt upgrade
```

### disable guest session
```sh
echo '
[SeatDefaults]
allow-guest=false
' | sudo tee /usr/share/lightdm/lightdm.conf.d/50-guest-allow.conf
```


### install exfat, hfs+
```sh
sudo apt install exfat-utils exfat-fuse hfsplus
```

### disable crash report
> enabled=0

```sh
sudo nano /etc/default/apport
```


### GTK TreeView Key Config
> @see http://stackoverflow.com/questions/4747264/is-it-possible-to-use-arrow-keys-alone-to-expand-tree-node-in-package-explorer-i

```sh
echo '
binding "gtk-binding-tree-view" {
    bind "j"        { "move-cursor" (display-lines, 1) }
    bind "k"        { "move-cursor" (display-lines, -1) }
    bind "h"        { "expand-collapse-cursor-row" (1,0,0) }
    bind "l"        { "expand-collapse-cursor-row" (1,1,0) }
    bind "o"        { "move-cursor" (pages, 1) }
    bind "u"        { "move-cursor" (pages, -1) }
    bind "g"        { "move-cursor" (buffer-ends, -1) }
    bind "y"        { "move-cursor" (buffer-ends, 1) }
    bind "p"        { "select-cursor-parent" () }
    bind "Left"     { "expand-collapse-cursor-row" (0,0,0) }
    bind "Right"    { "expand-collapse-cursor-row" (0,1,0) }
    bind "semicolon" { "expand-collapse-cursor-row" (0,1,1) }
    bind "slash"    { "start-interactive-search" () }
}
class "GtkTreeView" binding "gtk-binding-tree-view"
' >> ~/.gtkrc-2.0
```

### GTK Scrollbar
```sh
echo '
style "myscrollbar"
{
     GtkScrollbar::slider-width=10
}
class "GtkScrollbar" style "myscrollbar"
' >>  ~/.gtkrc-2.0
```

### Key Remapping ()
```sh
sudo nano /etc/default/keyboard
```

Left Ctrl <-> CapsLock
~~~
	XKBOPTIONS="ctrl:swapcaps"
~~~

No CapsLock
~~~
	XKBOPTIONS="ctrl:nocaps"
~~~


### Key Remapping (Right Alt -> Menu)
```sh
echo "
! Change Alt_R to Menu
keycode 0x6c = Menu
" > ~/.Xmodmap

echo '[[ -f ~/.Xmodemap ]] && xmodmap ~/.Xmodmap' >> ~/.xinitrc
```


### IME
```sh
sudo apt install ibus
```

#### Chinese Pinyin
http://nakamura-hiroshi.com/ubuntu/2011/05/ubuntu-1104-1.php

```sh
sudo apt install ibus-pinyin ibus-libpinyin
```

#### Japanese Anthy
```sh
sudo apt install ibus-anthy
```

#### Japanese Mozc
```sh
sudo apt install ibus-mozc
```

> Settings -> Language Support -> Install / Remove Languages ...
> Settings -> Keyboard Input Methods ...



 tools
------------------------------------
### ms fonts
```sh
sudo add-apt-repository multiverse
sudo apt update
sudo apt install ttf-mscorefonts-installer
```

### file manager
```sh
sudo apt install doublecmd-gtk doublecmd-help-en
```

### rar
```sh
sudo apt install rar unrar
```

### 7zip
```sh
sudo apt install p7zip-full
```

### usb creator
```sh
sudo apt install usb-creator-gtk
```

### chrome
```sh
wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google*
```

### beyond compare
```sh
wget http://www.scootersoftware.com/bcompare-4.0.0.18847_i386.deb
sudo dpkg -i bcompare*
```

### google calendar
```sh
sudo add-apt-repository ppa:atareao/atareao
sudo apt update
sudo apt install calendar-indicator
```

### editor
```sh
sudo apt install geany
```

Troubleshoot: invisible underscore
> Menu / View / Change Font ... / Choose 'Andale Mono Regular'


### opera
```sh
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
sudo add-apt-repository 'deb https://deb.opera.com/opera-stable/ stable non-free'
sudo apt-get update
sudo apt-get install opera-stable
```

### teams
```sh
curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -

sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/ms-teams stable main" > /etc/apt/sources.list.d/teams.list'

sudo apt update
sudo apt install teams
```

### remote desktop
```sh
sudo apt install remmina
```

### filezilla
```sh
sudo apt install filezilla
```

### emule
```sh
sudo apt install amule
```

### dolphin-emu
```sh
sudo add-apt-repository ppa:glennric/dolphin-emu
sudo apt update
sudo apt install dolphin-emu-master
```

### kodi
```sh
sudo apt install software-properties-common
sudo add-apt-repository ppa:team-xbmc/ppa
sudo apt update
sudo apt install kodi
```

### image editor
```sh
sudo apt install gimp imagemagick optipng

sudo add-apt-repository ppa:inkscape.dev/stable
sudo apt update
sudo apt install inkscape
```

### image viewer
```sh
wget http://download.xnview.com/XnViewMP-linux-x64.deb
sudo dpkg -i XnViewMP-linux-x64.deb
```

### photo manager
```sh
sudo apt install digikam
```

### music
```sh
sudo apt install libav-tools gstreamer0.10-plugins-ugly
```

### music player
```sh
sudo apt install clementine
```

### cd ripper
```sh
sudo apt install ripperx
sudo apt install lame libmp3lame0
```

### video editor
```sh
sudo apt install avidemux
```

### video converter
```sh
sudo apt install handbrake
```

### dvd & video player
```sh
sudo apt install libdvdread4
sudo /usr/share/doc/libdvdread4/install-css.sh
sudo apt install regionset
sudo apt install vlc browser-plugin-vlc
```

### dvd burner
```sh
sudo apt remove brasero
sudo apt install k3b
```

### dvdrip
```sh
sudo apt install acidrip
```

### mdf/mds to iso
```sh
sudo apt install mdf2iso
```

### launcherpad (Fullscreen)
http://www.noobslab.com/2015/03/slingscold-launcher-fixed-for-all.html

```sh
sudo add-apt-repository ppa:noobslab/apps
sudo apt update
sudo apt install slingscold
```

### cpulimit
```sh
sudo apt install cpulimit
```

### mac theme
http://logico.com.ar/blog/os-x-yosemite-xfce-theme


### arc theme
https://github.com/horst3180/arc-theme

install
```sh
git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme
./autogen.sh --prefix=/usr
sudo make install
```

uninstall
```sh
sudo make uninstall
sudo rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}
```


### fix broken dependency
```sh
sudo apt -f install
```

### oracle virtualbox
download .deb file and install

enable connect iphone usb to virtualbox
```sh
sudo usermod -a -G vboxusers username
```

linux guest: allow user to access virtual box shared folder on /media/sf_*
```sh
sudo usermod -a -G vboxsf username
```

