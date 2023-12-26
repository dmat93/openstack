#!/bin/sh
password="root"

sudo mysql -e "CREATE DATABASE glance;"
sudo mysql -e "CREATE USER 'glance'@'%' IDENTIFIED BY '"$password"';"
sudo mysql -e "CREATE USER 'glance'@'localhost' IDENTIFIED BY'"$password"';"
sudo mysql -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON glance.* TO 'glance'@'%';"
sudo mysql -e  "FLUSH PRIVILEGES;"
