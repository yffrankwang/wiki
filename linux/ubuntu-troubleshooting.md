## Set the BIOS clock to local time instead of UTC in a systemd-based version (15.04 and above)

You can set the hardware clock time standard through the command line. You can check what you have set to use by:
$ timedatectl | grep local

The hardware clock can be queried and set with the timedatectl command. To change the hardware clock time standard to localtime, use:
$ timedatectl set-local-rtc 1

If you want to revert to the hardware clock being in UTC, do:
$ timedatectl set-local-rtc 0


## How To Fix System Program Problem Detected In Ubuntu
https://itsfoss.com/how-to-fix-system-program-problem-detected-ubuntu/

```sh
sudo rm /var/crash/*
```

## Ubuntu add repo app-key fails

https://serverfault.com/questions/1022078/ubuntu-add-repo-app-key-fails

```sh
sudo curl https://www.pgadmin.org/static/packages_pgadmin_org.pub | sudo apt-key add
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100  3935  100  3935    0     0   2520      0  0:00:01  0:00:01 --:--:--  2519
gpg: invalid key resource URL '/tmp/apt-key-gpghome.Cs3KVx5Wsw/home:manuelschneid3r.asc.gpg'
gpg: keyblock resource '(null)': General error
gpg: key 7721F63BD38B4796: 2 signatures not checked due to missing keys
gpg: key 1488EB46E192A257: 1 signature not checked due to a missing key
gpg: key 7721F63BD38B4796: 2 signatures not checked due to missing keys
gpg: key 1488EB46E192A257: 1 signature not checked due to a missing key
gpg: key 7721F63BD38B4796: 2 signatures not checked due to missing keys
gpg: key 3B4FE6ACC0B21F32: 3 signatures not checked due to missing keys
gpg: key D94AA3F0EFE21092: 3 signatures not checked due to missing keys
gpg: key 871920D1991BC93C: 1 signature not checked due to a missing key
gpg: key 8881B2A8210976F2: 1 signature not checked due to a missing key
gpg: Total number processed: 23
gpg:       skipped new keys: 23
```

### solution:
Just ran into a very simalar problem and by deleting the problem key in /etc/apt/trusted.gpg.d/{Problem-Key}.asc

