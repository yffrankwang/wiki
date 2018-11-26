# develop

~~~
sudo yum install gettext-devel expat-devel curl-devel zlib-devel openssl-devel
cd /usr/local/src
wget https://www.kernel.org/pub/software/scm/git/git-1.8.5.tar.gz
tar xzvf git-1.8.5.tar.gz
cd git-1.8.5
sudo ./configure
sudo make all
sudo make install


wget http://ftp.jaist.ac.jp/pub/apache/maven/maven-3/3.2.1/binaries/apache-maven-3.2.1-bin.tar.gz
tar xvzf apache-maven-3.2.1-bin.tar.gz
sudo mv apache-maven-3.2.1 /opt/
sudo ln -s apache-maven-3.2.1 /opt/apache-maven


wget http://ftp.jaist.ac.jp/pub/apache//ant/binaries/apache-ant-1.9.4-bin.tar.gz
tar xvzf apache-ant-1.9.4-bin.tar.gz
sudo mv apache-ant-1.9.4 /opt/
sudo ln -s apache-ant-1.9.4 /opt/apache-ant

wget http://ftp.tsukuba.wide.ad.jp/software/apache//ant/ivy/2.4.0-rc1/apache-ivy-2.4.0-rc1-bin.tar.gz
tar xvzf apache-ivy-2.4.0-rc1-bin.tar.gz
sudo mv apache-ivy-2.4.0-rc1 /opt/
sudo ln -s apache-ivy-2.4.0-rc1 /opt/apache-ivy

sudo cp /opt/apache-ivy/ivy-2.4.0-rc1.jar /opt/apache-ant/lib/

wget http://ftp.meisei-u.ac.jp/mirror/apache/dist/maven/ant-tasks/2.1.3/binaries/maven-ant-tasks-2.1.3.jar
sudo mv maven-ant-tasks-2.1.3.jar /opt/apache-ant/lib/

echo "
PATH=\$PATH:/opt/apache-maven/bin:/opt/apache-ant/bin
export PATH
export MAVEN_HOME=/opt/apache-maven
export ANT_HOME=/opt/apache-ant
" >> ~/.bash_profile

~~~
