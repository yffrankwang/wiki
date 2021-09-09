### apache umask
```sh
echo '

# umask 002 to create files with 0664 and folders with 0775
umask 002

' | sudo tee -a /etc/apache2/envvars
