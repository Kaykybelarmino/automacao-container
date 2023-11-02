sudo docker stop container-mysql
sudo docker rm container-mysql
sudo docker image rm mysql-image 
sudo docker image rm mysql 
sudo docker volume rm volume-mysql 
sudo docker stop container-java
sudo docker rm container-java
cd ..
rm -rf automacao-container 

