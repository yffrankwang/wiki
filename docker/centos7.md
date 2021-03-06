# docket centos7

## get image
	 docker pull centos:centos7
	 docker images

## run container
	 docker run -it -d --name centos7 centos:centos7

## list process
	docker ps

## run bash
	docker exec -it centos7 /bin/bash
	
	yum install nano which openssh-clients

## stop container
	docker stop centos7

## start container
	docker start centos7

## delete container
	docker rm centos7


