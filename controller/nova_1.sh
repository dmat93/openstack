#!/bin/sh

password=$1
sudo mysql -e "CREATE DATABASE nova_api;"
sudo mysql -e "CREATE DATABASE nova;"
sudo mysql -e "CREATE DATABASE nova_cell0;"

sudo mysql -e "CREATE USER 'nova'@'%' IDENTIFIED BY '"$password"';"
sudo mysql -e "CREATE USER 'nova'@'localhost' IDENTIFIED BY'"$password"';"

sudo mysql -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON nova_api.* TO 'nova'@'%';"

sudo mysql -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON nova.* TO 'nova'@'%';"

sudo mysql -e "GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON nova_cell0.* TO 'nova'@'%';"

sudo mysql -e  "FLUSH PRIVILEGES;"
