# docket centos7

## get image
```sh
docker pull centos:centos7
docker images
```

## run container
```sh
docker run -it -d --name centos7 centos:centos7
```

## list process
```sh
docker ps
```

## run bash
```sh
docker exec -it centos7 /bin/bash

yum install nano which openssh-clients
```

## stop container
```sh
docker stop centos7
```

## start container
```sh
docker start centos7
```

## delete container
```sh
docker rm centos7
```


