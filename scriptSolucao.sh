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

echo "Construindo imagem MySQL"
sudo docker build -t mysql-image -f mysql.dockerfile .

echo "Instalando automação via macro"
sudo apt-get install xdotool -y

echo "Criando container MySQL"
sudo docker run -d -p 3306:3306 --name container-mysql -v volume-mysql:/var/lib/mysql mysql-image 

sleep 2

sudo docker stop container-mysql
sudo docker start container-mysql

sudo java -jar apiLoocaTeste1-1.0-SNAPSHOT-jar-with-dependencies.jar

echo "Entrando no banco de dados.."
sudo docker exec -it container-mysql bash
mysql -u medconnect -p medconnect123


# echo "Construindo imagem Python"
# sudo docker build -t python-image -f python.dockerfile .

# echo "Criando container Python"
# sudo docker run -d -p 80:80 --name container-python --network host python-image
