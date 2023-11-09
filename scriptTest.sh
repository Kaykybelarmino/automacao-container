#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

java --version

if [ $? -ne 0 ]; then
    echo "Inicializando instalação do java"
    sudo apt install openjdk-19-jre-headless -y
fi

docker --version

if [ $? -ne 0 ]; then
    echo "Inicializando instalação do docker"
    sudo apt install docker.io -y
fi

echo "Inicializando o serviço docker"
sudo systemctl start docker
sudo systemctl enable docker

echo "Criando volume do MySQL"
sudo docker volume create volume-mysql

echo "Criando container MySQL"
sudo docker run -d -p 3306:3306 --name container-mysql -v volume-mysql:/var/lib/mysql -e "MYSQL_ROOT_PASSWORD=segredo" -e "MYSQL_DATABASE=medconnect" mysql:8.0
sudo docker cp script_formatadoV1.sql "container-mysql:script_formatadoV1.sql"
sudo docker start container-mysql
sudo docker exec -i container-mysql sh -c 'mysql -u root -psegredo < script_formatadoV1.sql'
sudo java -jar apiLoocaTeste1-1.0-SNAPSHOT-jar-with-dependencies.jar


