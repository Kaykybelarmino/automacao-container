#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install docker.io -y
sudo docker pull mysql
sudo docker volume create volume-mysql
sudo docker image build -t mysql-image -f mysql.dockerfile . 
sudo docker run -d -p 3306:3306 --name container-mysql -v "volume-mysql:/var/lib/mysql" --network host mysql-image 
sudo docker image build -t java-image -f java.dockerfile .
sudo docker run --name container-java --network host java-image 


