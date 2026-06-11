## install

### OpenSearch
```sh
# x64
wget https://artifacts.opensearch.org/releases/bundle/opensearch/2.11.1/opensearch-2.11.1-linux-x64.deb
sudo dpkg -i opensearch-dashboards-2.11.1-linux-x64.deb

# arm64
wget https://artifacts.opensearch.org/releases/bundle/opensearch/2.11.1/opensearch-2.11.1-linux-arm64.deb
sudo dpkg -i opensearch-2.11.1-linux-arm64.deb

sudo systemctl daemon-reload
sudo systemctl enable opensearch
sudo systemctl start opensearch

curl -X GET https://localhost:9200 -u 'admin:admin' --insecure
```

sudo nano /etc/opensearch/opensearch.yml
```
network.host: 0.0.0.0
discovery.seed_hosts: ["0.0.0.0"]
```


### OpenSearch Dashboard
```sh
# x64
wget https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/2.11.1/opensearch-dashboards-2.11.1-linux-x64.deb
sudo dpkg -i opensearch-dashboards-2.11.1-linux-x64.deb

# arm64
wget https://artifacts.opensearch.org/releases/bundle/opensearch-dashboards/2.11.1/opensearch-dashboards-2.11.1-linux-arm64.deb
sudo dpkg -i opensearch-dashboards-2.11.1-linux-arm64.deb

sudo systemctl daemon-reload
sudo systemctl enable opensearch-dashboards
sudo systemctl start opensearch-dashboards
```

sudo nano /etc/opensearch-dashboards/opensearch_dashboards.yml
```
server.host: 0.0.0.0
```

http://localhost:5601/


### backup config
```sh
mkdir ~/backup
cd ~/backup
sudo /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh -r\
 -icl \
 -cacert /etc/opensearch/root-ca.pem \
 -cert /etc/opensearch/kirk.pem \
 -key /etc/opensearch/kirk-key.pem
```

### Change Admin Password
/usr/share/opensearch/plugins/opensearch-security/tools/hash.sh -p 'newpassword'

sudo nano /etc/opensearch/opensearch-security/internal_users.yml

sudo /usr/share/opensearch/plugins/opensearch-security/tools/securityadmin.sh \
 -icl \
 -t internalusers \
 -f /etc/opensearch/opensearch-security/internal_users.yml \
 -cacert /etc/opensearch/root-ca.pem \
 -cert /etc/opensearch/kirk.pem \
 -key /etc/opensearch/kirk-key.pem

