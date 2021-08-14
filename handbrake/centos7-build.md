# Build HandBrake on CentOS 7

see 
* https://handbrake.fr/docs/en/1.2.0/developer/install-dependencies-centos.html
* https://handbrake.fr/docs/en/1.2.0/developer/build-linux.html


## Get source
```sh
git clone https://github.com/HandBrake/HandBrake.git && cd HandBrake
git tag --list | grep ^1\.2\.
git checkout refs/tags/$(git tag -l | grep -E '^1\.2\.[0-9]+$' | tail -n 1)
git status
```

## Install dependencies 
```sh
sudo yum groupinstall "Development Tools" "Additional Development"
sudo yum install fribidi-devel git jansson-devel libogg-devel libsamplerate-devel libtheora-devel libvorbis-devel opus-devel speex-devel xz-devel
sudo yum install epel-release
sudo yum install libass-devel yasm
sudo yum localinstall $(curl -L -s 'https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/Packages/o/' | grep -Eo 'opus-[^">]+\.x86_64\.rpm' | sort -u | awk '{ print "https://archives.fedoraproject.org/pub/archive/epel/6/x86_64/Packages/o/"$0 }')


sudo yum repo-pkgs zmrepo remove
sudo yum remove zmrepo

sudo yum localinstall --nogpgcheck https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm
sudo yum install lame-devel x264-devel
sudo yum install centos-release-scl
sudo yum install devtoolset-7
sudo scl enable devtoolset-7 bash
```

## Install nasm
```sh
wget  https://www.nasm.us/pub/nasm/releasebuilds/2.15.05/nasm-2.15.05.tar.gz
tar xzvf nasm-2.15.05.tar.gz
cd nasm-2.15.05
ll
./configure
make
sudo make install
```

## build
```sh
cd ./HandBrake/
./configure --launch-jobs=$(nproc) --launch
cd build/
make
nano gtk/Makefile
make
nano gtk/Makefile
make
cd gtk
make
cd ..
make
sudo make install
```
