#!/bin/sh
ip=$1
sudo apt install mariadb-server python3-pymysql -y
sudo touch /etc/mysql/mariadb.conf.d/99-openstack.cnf

sudo echo \
"[mysqld]
bind-address = "$ip"
default-storage-engine = innodb
innodb_file_per_table = on
max_connections = 4096
collation-server = utf8_general_ci
character-set-server = utf8"> /etc/mysql/mariadb.conf.d/99-openstack.cnf

service mysql restart
