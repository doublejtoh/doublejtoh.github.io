---
layout: post
title: 우분투 14.04 에서 mongoDB 설치하기
---

https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/를 참고하여 작성하였습니다.

1. package management system이 사용하는 public key import하기

sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

2. 리스트 파일 for mongoDB 만들기
Ubuntu 12.04 (deprecated):
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu precise/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

Ubuntu 14.04:
echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu trusty/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

Ubuntu 16.04:
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

3.Reload local package database.

sudo apt-get update

4. 최선 버전의 안정된 mongoDB설치

sudo apt-get install -y mongodb-org


5. 몽고DB 서버 시작하기

sudo service mongod start

여기서 mongd를 인식하지 못한다고 하여 알아보니 sudo service mongodb start를 해보라고 해서 해봤더니.. 
* Starting database mongodb
...fail 
이런 오류가 떴다. 또 구글링해보니, sudo -u mongodb mongod --dbpath /var/lib/mongodb 이런식으로 경로를 지정해주니,서버가 
켜졌다. (https://stackoverflow.com/questions/17527606/mongodb-failing-on-debian 참고)
끝!
