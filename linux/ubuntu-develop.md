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
sudo apt install libxml2-dev libssl-dev libcurl4-openssl-dev
```

## heroku CLI
> curl https://cli-assets.heroku.com/install-ubuntu.sh | sh


## postgresql
```sh
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

sudo apt update

sudo apt install postgresql postgresql-contrib

sudo apt install libpq-dev
```

### pgadmin4
https://www.pgadmin.org/download/pgadmin-4-apt/

```sh
# Install the public key for the repository (if not done previously):
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add

# Create the repository configuration file:
sudo sh -c 'echo "deb https://ftp.postgresql.org/pub/pgadmin/pgadmin4/apt/$(lsb_release -cs) pgadmin4 main" > /etc/apt/sources.list.d/pgadmin4.list && apt update'

#
# Install pgAdmin
#

# Install for both desktop and web modes:
sudo apt install pgadmin4

# Install for desktop mode only:
sudo apt install pgadmin4-desktop

# Install for web mode only:
sudo apt install pgadmin4-web

# Configure the webserver, if you installed pgadmin4-web:
sudo /usr/pgadmin4/bin/setup-web.sh
```

disable master password
```sh
echo '
MASTER_PASSWORD_REQUIRED = False
SERVER_MODE = False
' | sudo tee -a /usr/pgadmin4/web/config_local.py
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

## golang (1.16)
> sudo yum -y install golang

or

```sh
wget https://golang.org/dl/go1.16.7.linux-amd64.tar.gz
tar -xzvf go1.16.7.linux-amd64.tar.gz
sudo mv go /opt/go-1.16.7
cd /opt/
sudo ln -s go-1.16.7 go

echo '
# go
export PATH="/opt/go/bin:$PATH"
export GO111MODULE=on
' >> ~/.bashrc
```

## java
```sh
sudo apt install openjdk-8-jdk openjdk-8-source
sudo apt install openjdk-11-jdk openjdk-11-source

ls -la /etc/alternatives/java
sudo update-alternatives --config java

ls -la /etc/alternatives/javac
sudo update-alternatives --config javac

echo '
export JAVA_HOME=$(readlink -f /usr/bin/javac | sed "s:/bin/javac::")
' >> ~/.bashrc
```

## nodejs
```sh
sudo apt install nodejs-dev node-gyp libssl1.0-dev
sudo apt install nodejs npm
sudo ln -s `which nodejs` /usr/local/bin/node
```

### nvm: node version manager
```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

echo '
# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
' >> ~/.bashrc
```

```sh
nvm ls-remote
nvm install v10.24.1
nvm alias default v10.24.1
nvm ls
nvm use x.y.z
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
# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if which pyenv > /dev/null; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi
' >> ~/.bashrc
```

```sh
pyenv install -l
pyenv install 3.9.6
pyenv versions
pyenv global 3.9.6
pip install pymysql
```

pip update all packages
```
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs pip install -U

```

### rbenv
https://github.com/rbenv/rbenv

```sh
sudo apt install -y libreadline-dev zlib1g-dev

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
cd ~/.rbenv && src/configure && make -C src

git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo '
# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi
' >> ~/.bashrc
```

```sh
rbenv install -l
rbenv install 2.5.1
rbenv versions
rbenv global 2.5.1
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

