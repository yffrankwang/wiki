https://www.tericle.jp/oci-ubuntu-iptables/
https://newbedev.com/opening-port-80-on-oracle-cloud-infrastructure-compute-node

## iptables
```sh
sudo iptables-save > ~/iptables-rules.org

iptables -P INPUT ACCEPT
iptables -P OUTPUT ACCEPT
iptables -P FORWARD ACCEPT
iptables -F

sudo /etc/init.d/netfilter-persistent save
sudo /etc/init.d/netfilter-persistent reload
```

