 How to Mount FTP Share on Linux Using Curlftps
-------------------------------

https://www.looklinux.com/mount-ftp-share-on-linux-using-curlftps/

```sh
sudo apt-get install curlftpfs
```

- FTP User      : sagar
- FTP Password  : pass@123
- FTP Server    : ftp.looklinux.com
- Mount Point   : /ftpmount

```sh
mkdir ~/ftpmount

curlftpfs sagar:pass@123@ftp2.looklinux.com /ftpmount

```
