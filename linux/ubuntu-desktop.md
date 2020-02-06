### shortcut location
	cd /usr/share/applications

### lightdm background location
	cd /usr/share/backgrounds

### system clock
> @see https://help.ubuntu.com/community/UbuntuTime
> UTC=yes

	sudo sed -i 's/UTC=no/UTC=yes/' /etc/default/rcS
	timedatectl set-local-rtc 0 --adjust-system-clock


### grub-customizer
	sudo add-apt-repository ppa:danielrichter2007/grub-customizer
	sudo apt-get update
	sudo apt-get install grub-customizer

### boot-repair
	sudo add-apt-repository ppa:yannubuntu/boot-repair
	sudo apt-get update
	sudo apt-get install boot-repair boot-info


### dir location settings
> XDG_DESKTOP_DIR="$HOME/Desktop"

	cat ~/.config/user-dirs.dirs


### update
	sudo apt-get update
	sudo apt-get upgrade


### disable guest session
~~~
echo "
[SeatDefaults]
allow-guest=false
" | sudo tee /usr/share/lightdm/lightdm.conf.d/50-guest-allow.conf
~~~


### install exfat, hfs+
sudo apt-get install exfat-utils exfat-fuse hfsplus


### disable crash report
> enabled=0

	sudo nano /etc/default/apport



### GTK TreeView Key Config
> @see http://stackoverflow.com/questions/4747264/is-it-possible-to-use-arrow-keys-alone-to-expand-tree-node-in-package-explorer-i

~~~
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
~~~

### GTK Scrollbar
~~~
echo '
style "myscrollbar"
{
     GtkScrollbar::slider-width=10
}
class "GtkScrollbar" style "myscrollbar"
' >>  ~/.gtkrc-2.0
~~~

### Key Remapping ()

sudo nano /etc/default/keyboard

Left Ctrl <-> CapsLock
~~~
	XKBOPTIONS="ctrl:swapcaps"
~~~

No CapsLock
~~~
	XKBOPTIONS="ctrl:nocaps"
~~~


### Key Remapping (Right Alt -> Menu)
~~~
echo "
! Change Alt_R to Menu
keycode 0x6c = Menu
" > ~/.Xmodmap

echo '[[ -f ~/.Xmodemap ]] && xmodmap ~/.Xmodmap' >> ~/.xinitrc
~~~


### IME
	sudo apt-get install ibus

#### Chinese Pinyin
	#http://nakamura-hiroshi.com/ubuntu/2011/05/ubuntu-1104-1.php
	sudo apt-get install ibus-pinyin ibus-libpinyin

#### Japanese Anthy
	sudo apt-get install ibus-anthy

#### Japanese Mozc
	sudo apt-get install ibus-mozc

	# > Settings -> Language Support -> Install / Remove Languages ...
	# > Settings -> Keyboard Input Methods ...



 tools
------------------------------------

### file manager
	sudo apt-get install doublecmd-gtk doublecmd-help-en

### rar
	sudo apt-get install rar unrar

### 7zip
	sudo apt-get install p7zip-full

### usb creator
	sudo apt-get install usb-creator-gtk

### chrome
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb
	wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	sudo dpkg -i google*

### beyond compare
	wget http://www.scootersoftware.com/bcompare-4.0.0.18847_i386.deb
	sudo dpkg -i bcompare*

evaluation forever
~~~
echo 'rm ~/.config/bcompare/registry.dat' >> .xinitrc
~~~

### google calendar
	sudo add-apt-repository ppa:atareao/atareao
	sudo apt-get update
	sudo apt-get install calendar-indicator

### editor
	sudo apt-get install geany

### remote desktop
	sudo apt-get install remmina

### filezilla
	sudo apt-get install filezilla

### emule
	sudo apt-get install amule

### dolphin-emu
	sudo add-apt-repository ppa:glennric/dolphin-emu
	sudo apt-get update
	sudo apt-get install dolphin-emu-master

### kodi
	sudo apt-get install software-properties-common
	sudo add-apt-repository ppa:team-xbmc/ppa
	sudo apt-get update
	sudo apt-get install kodi

### image editor
	sudo apt-get install gimp inkscape

### image viewer
	wget http://download.xnview.com/XnViewMP-linux-x64.deb
	sudo dpkg -i XnViewMP-linux-x64.deb

### photo manager
	sudo apt-get install digikam

### music
	sudo apt-get install libav-tools gstreamer0.10-plugins-ugly

### music player
	sudo apt-get install clementine

### cd ripper
	sudo apt-get install ripperx
	sudo apt-get install lame libmp3lame0

### video editor
	sudo apt-get install avidemux

### video converter
	sudo apt-get install handbrake

### dvd & video player
	sudo apt-get install libdvdread4
	sudo /usr/share/doc/libdvdread4/install-css.sh
	sudo apt-get install regionset
	sudo apt-get install vlc browser-plugin-vlc

### dvd burner
	sudo apt-get remove brasero
	sudo apt-get install k3b

### dvdrip
	sudo apt-get install acidrip

### mdf/mds to iso
	sudo apt-get install mdf2iso

### launcherpad (Fullscreen)
	### http://www.noobslab.com/2015/03/slingscold-launcher-fixed-for-all.html
	sudo add-apt-repository ppa:noobslab/apps
	sudo apt-get update
	sudo apt-get install slingscold

### cpulimit
	sudo apt-get install cpulimit


### mac theme
	http://logico.com.ar/blog/os-x-yosemite-xfce-theme


### arc theme
see https://github.com/horst3180/arc-theme

install
	git clone https://github.com/horst3180/arc-theme --depth 1 && cd arc-theme
	./autogen.sh --prefix=/usr
	sudo make install

uninstall
	sudo make uninstall
	sudo rm -rf /usr/share/themes/{Arc,Arc-Darker,Arc-Dark}



################################
### fix broken dependency
###
sudo apt-get -f install

#################################
### develop
###

### build essential
	sudo apt-get install build-essential

### python
	sudo apt-get install python python-pip python3 python3-pip

	sudo pip install --upgrade pytz tzlocal python-dateutil google-api-python-client jsbeautifier exifread python-oauth2 oauth2client
	sudo pip install onedrivesdk==1.1.8
	sudo pip3 install --upgrade pytz tzlocal python-dateutil google-api-python-client jsbeautifier exifread python-oauth2 oauth2client
	sudo pip3 install onedrivesdk==1.1.8

### svn, git, cmake, doxygen
	sudo apt-get install subversion git cmake doxygen checkinstall

### config git
	git config --global core.autocrlf false


### oracle java
	sudo add-apt-repository ppa:linuxuprising/java
	sudo apt update
	sudo apt install oracle-java*-installer


### java7
 - https://packages.debian.org/experimental/openjdk-7-jdk
 - https://packages.debian.org/experimental/openjdk-7-jre
 - https://packages.debian.org/experimental/openjdk-7-jre-headless
 - https://packages.debian.org/experimental/openjdk-7-source
 - https://packages.debian.org/sid/libjpeg62-turbo

	sudo dpkg -i openjdk-7-* libjpeg62-turbo*

	sudo add-apt-repository ppa:openjdk-r/ppa
	sudo apt-get update
	sudo apt-get install openjdk-7-jdk openjdk-7-source

### java8
	sudo apt-get install openjdk-8-jdk openjdk-8-source


### nodejs
	sudo apt-get install nodejs-dev node-gyp libssl1.0-dev
	sudo apt-get install nodejs npm
	sudo ln -s `which nodejs` /usr/local/bin/node


### wireshark (select 'Yes' on config window)
sudo apt-get install wireshark

### manual config
	sudo dpkg-reconfigure wireshark-common
	sudo usermod -a -G wireshark username


### oracle virtualbox
download .deb file and install

	### enable connect iphone usb to virtualbox
	sudo usermod -a -G vboxusers username

	### linux guest: allow user to access virtual box shared folder on /media/sf_*
	sudo usermod -a -G vboxsf username

### fingerprint

	sudo add-apt-repository ppa:fingerprint/fingerprint-gui
	sudo apt-get update
	sudo apt-get install libbsapi policykit-1-fingerprint-gui fingerprint-gui

### thinkpad x1 carbon
	https://wiki.archlinux.org/index.php/Lenovo_ThinkPad_X1_Carbon_(Gen_5)

~~~
sudo apt install git libusb-1.0-0-dev libxv-dev
git clone https://github.com/nmikhailov/Validity90.git
cd Validity90/libfprint
./configure
make
make check
sudo make install
~~~
