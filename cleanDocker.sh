sudo docker stop container-mysql
sudo docker rm container-mysql
sudo docker image rm mysql-image 
sudo docker image rm mysql 
sudo docker volume rm volume-mysql 
cd ..
rm -rf automacao-container 

