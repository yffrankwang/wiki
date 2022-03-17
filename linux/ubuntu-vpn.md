 How to Setup an L2TP/IPsec VPN Client on Linux
--------------------------------------------------

## install vpn client
https://hnakamur.github.io/blog/2018/03/31/l2tp-vpn-on-ubuntu-17.10/


```sh
sudo add-apt-repository ppa:nm-l2tp/network-manager-l2tp
sudo apt-get update
sudo apt-get install network-manager-l2tp  network-manager-l2tp-gnome

sudo systemctl stop xl2tpd
sudo systemctl disable xl2tpd
```

https://royhills.co.uk/wiki/index.php/Ike-scan_Frequently_Asked_Questions
https://github.com/nm-l2tp/NetworkManager-l2tp/wiki/Known-Issues#querying-vpn-server-for-its-ikev1-algorithm-proposals
https://wiki.strongswan.org/projects/strongswan/wiki/IKEv1CipherSuites


## check vpn server ciphers

```sh
sudo apt install ike-scan

echo '#!/bin/sh
#
# sudo ipsec stop
# sudo ./ike-scan.sh 1.2.3.4 | grep SA=
#

# Encryption algorithms: 3des=5, aes128=7/128, aes192=7/192, aes256=7/256
ENCLIST="5 7/128 7/192 7/256"
# Hash algorithms: md5=1, sha1=2, sha256=5, sha384=6, sha512=7
HASHLIST="1 2 5 6 7"
# Diffie-Hellman groups: 1, 2, 5, 14, 15, 19, 20, 21
GROUPLIST="1 2 5 14 15 19 20 21"
# Authentication method: Preshared Key=1, RSA signatures=3
AUTHLIST="1 3"

for ENC in $ENCLIST; do
   for HASH in $HASHLIST; do
       for GROUP in $GROUPLIST; do
          for AUTH in $AUTHLIST; do
             echo ike-scan --trans=$ENC,$HASH,$AUTH,$GROUP -M "$@"
             ike-scan --trans=$ENC,$HASH,$AUTH,$GROUP -M "$@"
          done
      done
   done
done
' > ike-scan.sh

chmod a+rx ./ike-scan.sh

sudo ipsec stop
sudo ./ike-scan.sh 1.2.3.4 | grep SA=
```

## Troubleshoot

```sh
journalctl -f

```
