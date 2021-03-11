## install mysql
```sh
brew install openssl
brew install mysql
mysql.server start

mysql_secure_installation

mysql -uroot
> uninstall plugin validate_password;
> UNINSTALL COMPONENT 'file://component_validate_password';
> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
```

## install mysql workbench
https://dev.mysql.com/get/Downloads/MySQLGUITools/mysql-workbench-community-8.0.23-macos-x86_64.dmg

#### fix mysql workbench start error
```sh
brew install python@3.7
sudo ln -s /usr/local/Cellar/python@3.7/3.7.10_1/Frameworks/Python.framework /Library/Frameworks/Python.framework
```


## install python
```sh
brew install pyenv
echo 'if which pyenv > /dev/null; then eval "$(pyenv init - zsh)"; fi' >> ~/.zshrc

pyenv install -l
pyenv install 3.9.1
pyenv versions
pyenv global 3.9.1
pip install pymysql
```


## install perl
```sh
brew install plenv

echo 'if which plenv > /dev/null; then eval "$(plenv init - zsh)"; fi' >> ~/.zshrc

plenv install 5.32.1 -Dusethreads
plenv global 5.32.1
plenv versions
which perl
perl -e 'print $^V'
```

## install perl modules
```sh
brew install cpanminus

cpan install DateTime
cpan install DBI

brew install mysql-connector-c
export PATH=/usr/local/Cellar/mysql-client/8.0.23/bin/:$PATH
cpan install DBD::mysql
```
