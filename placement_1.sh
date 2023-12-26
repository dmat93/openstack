password=$1
sudo mysql -e "CREATE DATABASE placement;"
sudo mysql -e "CREATE USER 'placement'@'%' IDENTIFIED BY '"$password"';"
sudo mysql -e "CREATE USER 'placement'@'localhost' IDENTIFIED BY'"$password"';"
sudo mysql -e "GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'localhost';"
sudo mysql -e "GRANT ALL PRIVILEGES ON placement.* TO 'placement'@'%';"
sudo mysql -e  "FLUSH PRIVILEGES;"
