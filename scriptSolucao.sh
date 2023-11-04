#!/bin/bash

sudo apt update -y && sudo apt upgrade -y

java --version

if [ $? != 0 ] then;
    echo "Inicializando instalação do java"
    sudo apt install openjdk-20-jre-headless
fi

docker --version

if [ $? != 0 ] then;
    echo "Inicializando instalação do docker"
    sudo apt install docker.io
fi

echo "Inicializando o serviço docker"
sudo systemctl start docker
sudo systemctl enable docker

echo "Criando volume do MySQL"
sudo docker volume create volume-mysql

echo "Criando imagem MySQL"

sudo docker image build -t mysql-image -f mysql.dockerfile . 

echo "Criando container MySQL"
sudo docker run -d -p 3306:3306 --name container-mysql -v "volume-mysql:/var/lib/mysql" mysql-image

echo "Construindo imagem python"
sudo docker image build -t python-image -f python.dockerfile .

echo "Criando container Python"
sudo docker run -d -p 80:80 --name container-python --network host python-image

echo "Instalando automação via macro"
sudo apt-get install xdotool


echo "Executando nossa solução.."
sudo java -jar apiLoocaTeste1-1.0-SNAPSHOT-jar-with-dependencies.jar

echo "Desanexando terminal"
sudo xdotool key crtl+p
sleep 0.5
sudo xdotool key crtl+q

echo "Entrando no banco de dados.."
sudo docker exec -it container-mysql bash
mysql -u medconnect -p medconnect123
