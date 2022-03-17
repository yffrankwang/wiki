### restart wsl
> wslconfig /t Ubuntu


### change default user
```sh
echo '
[user]
default = username
' | sudo tee -a /etc/wsl.conf
```


### disable windows path
```sh
echo '
[interop]
appendWindowsPath = false
' | sudo tee -a /etc/wsl.conf
```


### login as root
> wsl -u root
