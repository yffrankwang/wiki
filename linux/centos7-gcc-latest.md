https://linuxhostsupport.com/blog/how-to-install-gcc-on-centos-7/

# Install GCC from source

If you need a newer version of GCC than the one distributed by the official CentOS 7 repositories you can install it from source.

It is highly recommended to start a screen session before starting the installation. Run the following command

	screen -U -S gcc

Download the tarball of the GCC version you want to install. In our example we will use GCC version 7.3.0

	wget http://ftp.mirrorservice.org/sites/sourceware.org/pub/gcc/releases/gcc-7.3.0/gcc-7.3.0.tar.gz

Unpack the tar archive and change the current working directory

	tar zxf gcc-7.3.0.tar.gz
	cd gcc-7.3.0

Install bzip2 and run the ‘download_prerequisites’ script to download some prerequisites needed by GCC. You have to run this from the top level of the GCC source tree.

	yum -y install bzip2
	./contrib/download_prerequisites

Once the prerequisites are downloaded execute the following command to start configuring the GCC build environment

	./configure --disable-multilib --enable-languages=c,c++

Once it is completed, run the following command to compile the source code. It may take a few hours for the compilation to complete, so sit back and relax.

	make -j 4
	make install

# Verify GCC installation on CentOS 7

After the compilation process is completed. You can check if GCC is properly installed.

	gcc --version

gcc (GCC) 7.3.0
Copyright (C) 2017 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
