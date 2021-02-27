## develop

### wireshark (select 'Yes' on config window)

	sudo apt-get install wireshark
	sudo dpkg-reconfigure wireshark-common
	sudo usermod -a -G wireshark username


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


### perl
	sudo apt install perl libdatetime-perl libdbd-mysql-perl
