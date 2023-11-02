#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install docker.io -y
sudo systemctl start docker
sudo systemctl enable docker
sudo docker pull mysql
sudo docker volume create volume-mysql
sudo docker image build -t mysql-image -f mysql.dockerfile . 
sudo docker run -d --ip 172.31.18.233 -p 3306:3306  --name container-mysql -v "volume-mysql:/var/lib/mysql" mysql-image 
sudo docker image build -t java-image -f java.dockerfile .
sudo docker run -d -p 90:90 --name container-java java-image 
sudo docker exec -i container-java java -jar app.jar



