#!/bin/sh

password=$1
ip_controller=$2

sudo apt install glance -y
sudo sed -i '/connection = ' /etc/glance/glance-api.conf
sudo sed -i '/\[database\]/d' /etc/glance/glance-api.conf
sudo sed -i '/\[keystone_authtoken\]/d' /etc/glance/glance-api.conf
sudo sed -i '/\[paste_deploy\]/d' /etc/glance/glance-api.conf
sudo sed -i '/\[glance_store\]/d' /etc/glance/glance-api.conf

sudo echo \
"[database]
connection = mysql+pymysql://glance:"$password"@"$ip_controller"/glance"\
>> /etc/glance/glance-api.conf

sudo echo \
"[keystone_authtoken]
www_authenticate_uri = http://"$ip_controller":5000
auth_url = http://"$ip_controller":5000
memcached_servers = "$ip_controller":11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = glance
password = "$password""\
>> /etc/glance/glance-api.conf

sudo echo \
"[paste_deploy]
flavor = keystone"\
>> /etc/glance/glance-api.conf

sudo echo \
"[glance_store]
stores = file,http
default_store = file
filesystem_store_datadir = /var/lib/glance/images/"\
>> /etc/glance/glance-api.conf

sudo su -s /bin/sh -c "glance-manage db_sync" glance
sudo service glance-api restart
