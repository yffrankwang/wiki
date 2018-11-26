# install svn1.8 on centos7

### Setup Yum Repository

Create a new repo file /etc/yum.repos.d/wandisco-svn.repo and add following content

~~~
echo '
[WandiscoSVN]
name=Wandisco SVN Repo
baseurl=http://opensource.wandisco.com/centos/7/svn-1.8/RPMS/$basearch/
enabled=1
gpgcheck=0
' | sudo tee /etc/yum.repos.d/wandisco-svn.repo
~~~

### Install Subversion Package

	# yum clean all
	# yum install subversion


