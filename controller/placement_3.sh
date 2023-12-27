#!/bin/sh
password=$1
ip=$2
sudo sed -i '/connection =/d ' /etc/placement/placement.conf
sudo sed -i '/\[api\]/d' /etc/placement/placement.conf
sudo sed -i '/\[keystone_authtoken\]/d' /etc/placement/placement.conf
sudo sed -i '/\[placement_database\]/d' /etc/placement/placement.conf


sudo echo \
"[placement_database]
connection = mysql+pymysql://placement:"$password"@controller/placement"\
>> /etc/placement/placement.conf

sudo echo \
"[keystone_authtoken]
auth_url = http://"$ip":5000/v3
memcached_servers = "$ip":11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = placement
password = "$password""\
>> /etc/placement/placement.conf

sudo echo \
"[api]
auth_strategy = keystone"\
>> /etc/placement/placement.conf


sudo su -s /bin/sh -c "placement-manage db sync" placement
sudo service apache2 restart
