PLACEMENT_PASS=`cat PLACEMENT_PASS`
sudo mysql -e "CREATE DATABASE placement;"
sudo mysql -e "CREATE USER 'placement'@'%' IDENTIFIED BY '"$PLACEMENT_PASS"';"
sudo mysql -e "CREATE USER 'placement'@'localhost' IDENTIFIED BY'"$PLACEMENT_PASS"';"
sudo mysql -e "GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'%';"
sudo mysql -e  "FLUSH PRIVILEGES;"
