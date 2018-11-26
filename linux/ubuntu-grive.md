#!/bin/bash -ex

#### grive x64 deb
~~~
wget http://www.lbreda.com/grive/_media/packages/0.2.0/grive_0.2.0-1_amd64.deb
sudo dpkg -i grive_0.2.0-1_amd64.deb
~~~

#### grive dependency
~~~
sudo apt-get install libgcrypt11-dev libjson0-dev libexpat1-dev
sudo apt-get install libcurl4-openssl-dev libzip-dev
sudo apt-get install libboost-all-dev libboost-test-dev
~~~

#### master
~~~
git clone git://github.com/lloyd/yajl
cd yajl
./configure
cmake .
make
sudo checkinstall
cd ..
~~~

#### 64bit
~~~
git clone https://github.com/Grive/grive.git
~~~

#### 32bit build error fixed
~~~
git clone https://github.com/foolite/grive.git
~~~

#### make
~~~
cd grive
cmake .
make
~~~

#### stable
~~~
wget http://www.lbreda.com/grive/_media/packages/0.2.0/grive-0.2.0.tar.gz
tar xvzf grive-0.2.0.tar.gz
cd grive-0.2.0
cmake .
make
~~~

#### deploy
~~~
sudo cp grive/grive /usr/local/bin
~~~

