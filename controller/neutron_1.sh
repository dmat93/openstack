#!/bin/sh

NEUTRON_PASS=`cat NEUTRON_PASS`
sudo mysql -e "CREATE DATABASE neutron;"


sudo mysql -e "CREATE USER 'neutron'@'%' IDENTIFIED BY '"$NEUTRON_PASS"';"
sudo mysql -e "CREATE USER 'neutron'@'localhost' IDENTIFIED BY'"$NEUTRON_PASS"';"
sudo mysql -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON neutron.* TO 'neutron'@'%';"
sudo mysql -e  "FLUSH PRIVILEGES;"

