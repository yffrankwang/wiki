https://www.tericle.jp/oci-ubuntu-iptables/
https://newbedev.com/opening-port-80-on-oracle-cloud-infrastructure-compute-node

## iptables
```sh
sudo iptables-save > ~/iptables-rules.org

sudo iptables -P INPUT ACCEPT
sudo iptables -P OUTPUT ACCEPT
sudo iptables -P FORWARD ACCEPT
sudo iptables -F

sudo /etc/init.d/netfilter-persistent save
sudo /etc/init.d/netfilter-persistent reload
```


## hostname
https://qiita.com/yamada-hakase/items/9c5647d22c923fc74330


## terraform
https://blogs.techvan.co.jp/oci/2019/04/08/terraform%e3%81%a7oci%e4%b8%8a%e3%81%ab%e4%bb%ae%e6%83%b3%e3%82%b5%e3%83%bc%e3%83%90%e3%82%92%e5%bb%ba%e3%81%a6%e3%81%a6%e3%81%bf%e3%81%9f/

