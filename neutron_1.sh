#!/bin/sh

password="root"
sudo mysql -e "CREATE DATABASE neutron;"


sudo mysql -e "CREATE USER 'neutron'@'%' IDENTIFIED BY '"$password"';"
sudo mysql -e "CREATE USER 'neutron'@'localhost' IDENTIFIED BY'"$password"';"
sudo mysql -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%';"
sudo mysql -e  "FLUSH PRIVILEGES;"

