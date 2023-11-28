#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

java --version

if [ $? -gt 0 ]; then
    echo "Inicializando instalação do java"
    sudo apt install openjdk-19-jre-headless -y
fi

docker --version

if [ $? -gt 0 ]; then
    echo "Inicializando instalação do docker"
    sudo apt install docker.io -y
fi

echo "Inicializando o serviço docker"
sudo systemctl start docker
sudo systemctl enable docker

echo "Criando volume do MySQL"
sudo docker volume create volume-mysql

echo "Criando container MySQL"
sudo docker image build -t mysql-image -f mysql.dockerfile .
sudo docker run -d -p 3306:3306 --name container-mysql -v volume-mysql:/docker-entrypoint-initdb.d -e "MYSQL_ROOT_PASSWORD=segredo" -e "MYSQL_DATABASE=medconnect" -e "MYSQL_INITDB_SKIP_TZINFO=yes" mysql-image

# Aguarda até que o MySQL esteja pronto para aceitar conexões
#while ! docker exec container-mysql mysqladmin ping --silent; do
sleep 15
#done

java -jar apiLoocaTeste1-1.0-SNAPSHOT-jar-with-dependencies.jar $
sleep 10
sudo docker image build -t python-image -f python.dockerfile .
sudo docker run -d -p 80:80 --name container-python python-image  






