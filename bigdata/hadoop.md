 hadoop
---------------

## user & directory
```sh
sudo useradd -m -u 19000 -s /bin/bash hadoop
sudo usermod --shell /bin/bash hadoop
sudo mkdir -p /opt/hadoop /var/hadoop
sudo chown -R hadoop:hadoop /opt/hadoop /var/hadoop
```

## install
```sh
sudo su - hadoop

# wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz
wget https://dlcdn.apache.org/hadoop/common/hadoop-3.3.1/hadoop-3.3.1-aarch64.tar.gz
tar xzvf hadoop*.gz
rm hadoop*.gz
mv hadoop* /opt/
ln -s hadoop-3.3.1 hadoop

```

