#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker volume create volume-mysql
sudo docker image build -t mysql-image -f mysql.dockerfile . 
sudo docker run --ip 172.31.18.233 -d -p 3306:3306 --name container-mysql -v "volume-mysql:/var/lib/mysql" mysql-image
sudo docker network create conexao-mysql 
sudo docker connect conexao-mysql container-mysql
sudo docker start container-mysql
sudo docker image build -t java-image -f java.dockerfile .
sudo docker run --network conexao-mysql --name container-java java-image 
sudo docker start container-java
sudo docker exec -i container-java java -jar app.jar




