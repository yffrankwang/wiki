### dependency

	sudo yum install -y xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 libXext libXrender 


### centos 6

	sudo yum install -y libjpeg-turbo libpng


### japanese fonts

	wget http://dl.ipafont.ipa.go.jp/IPAexfont/IPAexfont00301.zip
	unzip IPAexfont00301.zip 
	sudo cp -rf IPAexfont00301/ /usr/share/fonts/
