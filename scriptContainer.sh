#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install docker.io -y
sudo docker pull mysql
sudo docker volume create volume-mysql 
sudo docker run -d -p 3306:3306 --name container-mysql -w "volume-mysql:/var/lib/mysql" -e "MYSQL_ROOT_PASSWORD=segredo" mysql 
sudo docker cp script_formatadoV1.sql "container-mysql:script_formatadoV1.sql"
sudo docker exec -it container-mysql mysql -u root -psegredo -e "CREATE USER 'medconnect'@'%' IDENTIFIED BY 'medconnect123'; GRANT ALL PRIVILEGES ON *.* TO 'medconnect'@'%' WITH GRANT OPTION; source script_formatadoV1.sql;" 
sudo docker image build -t java-image -f java.dockerfile .
sudo docker run --name container-java java-image 
