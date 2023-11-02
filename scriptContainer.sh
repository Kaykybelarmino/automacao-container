#!/bin/bash

sudo apt update -y && sudo apt upgrade -y
sudo apt install docker.io -y
sudo docker pull mysql
sudo docker volume create volume-mysql 
sudo docker run -d -p 3306:3306 --name container-mysql -v "volume-mysql:/var/lib/mysql" -e "MYSQL_ROOT_PASSWORD=segredo" mysql 
sudo docker cp script_formatadoV1.sql "container-mysql:script_formatadoV1.sql"
sudo docker exec -it container-mysql bash 
mysql -u root -psegredo -e "CREATE USER 'medconnect'@'%' IDENTIFIED BY 'medconnect123';"
mysql -u root -psegredo -e "GRANT ALL PRIVILEGES ON *.* TO 'medconnect'@'%' WITH GRANT OPTION;"
mysql -u root -psegredo < script_formatadoV1.sql
exit
sudo docker image build -t java-image -f java.dockerfile .
sudo docker run --name container-java java-image 
