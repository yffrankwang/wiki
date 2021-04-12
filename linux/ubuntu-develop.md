# develop

## wireshark (select 'Yes' on config window)
```sh
sudo apt install wireshark
sudo dpkg-reconfigure wireshark-common
sudo usermod -a -G wireshark username
```

## build essential
```sh
sudo apt install build-essential
sudo apt install libxml2-dev
sudo apt install libssl-dev
```

## mysql-client
```sh
sudo apt install mysql-client
```

## svn, git, cmake, doxygen
```sh
sudo apt install subversion git cmake doxygen checkinstall
```

## config git
```sh
git config --global core.autocrlf false
```

## oracle java
```sh
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt install oracle-java*-installer
```

### java7
 - https://packages.debian.org/experimental/openjdk-7-jdk
 - https://packages.debian.org/experimental/openjdk-7-jre
 - https://packages.debian.org/experimental/openjdk-7-jre-headless
 - https://packages.debian.org/experimental/openjdk-7-source
 - https://packages.debian.org/sid/libjpeg62-turbo

```sh
sudo dpkg -i openjdk-7-* libjpeg62-turbo*

sudo add-apt-repository ppa:openjdk-r/ppa
sudo apt update
sudo apt install openjdk-7-jdk openjdk-7-source
```

### java8
```sh
sudo apt install openjdk-8-jdk openjdk-8-source
```

## python
```sh
sudo apt install python python-pip python3 python3-pip

sudo pip install --upgrade pytz tzlocal python-dateutil google-api-python-client jsbeautifier exifread python-oauth2 oauth2client
sudo pip install --upgrade simplejson requests httplib2 suds python-memcached beautifulsoup4 lxml psycopg2-binary pymysql
sudo pip install onedrivesdk==1.1.8
sudo pip3 install --upgrade pytz tzlocal python-dateutil google-api-python-client jsbeautifier exifread python-oauth2 oauth2client
sudo pip3 install --upgrade simplejson requests httplib2 suds-community python-memcached beautifulsoup4 lxml psycopg2-binary pymysql
sudo pip3 install onedrivesdk==1.1.8
```

### pyenv: python version manager
```sh
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash

echo '
#pyenv
export PATH="$HOME/.pyenv/bin:$PATH"
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
' >> ~/.bashrc

exit
```

```sh
pyenv install -l
pyenv install 3.9.1
pyenv versions
pyenv global 3.9.1
pip install pymysql
```

pip update all packages
```
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U

```

## nodejs
```sh
sudo apt install nodejs-dev node-gyp libssl1.0-dev
sudo apt install nodejs npm
sudo ln -s `which nodejs` /usr/local/bin/node
```

### nvm: node version manager
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash
exit
```

```sh
nvm ls-remote
nvm install 10.18
nvm alias default 10.18
nvm ls
nvm use x.y.z
```


## perl
```sh
sudo apt install perl liblocal-lib-perl libdatetime-perl libdbd-mysql-perl libmodule-build-tiny-perl libxml-libxml-perl
```

### plenv
```sh
git clone git://github.com/tokuhirom/plenv.git ~/.plenv
git clone git://github.com/tokuhirom/Perl-Build.git ~/.plenv/plugins/perl-build/

echo '
# plenv
export PATH="$HOME/.plenv/bin:$PATH"
if which plenv > /dev/null; then
  eval "$(plenv init -)"
fi
' >> ~/.bashrc

exit
```

```sh
plenv install 5.32.1 -Dusethreads
plenv global 5.32.1
plenv versions
which perl
perl -e 'print $^V'
```
