 spark
---------------

## install
```sh
wget https://dlcdn.apache.org/spark/spark-3.2.0/spark-3.2.0-bin-hadoop3.2.tgz

tar xzvf spark*.tgz
rm spark*.tgz
sudo mv spark-3.2.0-bin-hadoop3.2 /opt/
cd /opt/
sudo ln -s spark-3.2.0-bin-hadoop3.2 spark
```


## start

https://spark.apache.org/docs/latest/spark-standalone.html

```sh
cd /opt/spark
./sbin/start-master.sh
```

Once started, the master will print out a spark://HOST:PORT URL for itself,
which you can use to connect workers to it, or pass as the “master” argument to SparkContext.
You can also find this URL on the master’s web UI, which is http://localhost:8080 by default.

Similarly, you can start one or more workers and connect them to the master via:
```sh
./sbin/start-worker.sh <master-spark-URL>
```


