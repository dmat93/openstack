#!/bin/sh
ip=$1
password=$2
sudo apt install nova-compute -y

sudo sed -i '/connection = sqlite/d' /etc/nova/nova.conf
sudo sed -i '/connection = sqlite/d' /etc/nova/nova.conf
sudo sed -i '/log_dir =/d' /etc/nova/nova.conf
sudo sed -i '/lock_path =/d' /etc/nova/nova.conf
sudo sed -i '/state_path =/d' /etc/nova/nova.conf
sudo sed -i '/\[api_database\]/d' /etc/nova/nova.conf
sudo sed -i '/\[keystone_authtoken\]/d' /etc/nova/nova.conf
sudo sed -i '/\[database\]/d' /etc/nova/nova.conf
sudo sed -i '/\[DEFAULT\]/d' /etc/nova/nova.conf
sudo sed -i '/\[api\]/d' /etc/nova/nova.conf
sudo sed -i '/\[vnc\]/d' /etc/nova/nova.conf
sudo sed -i '/\[glance\]/d' /etc/nova/nova.conf
sudo sed -i '/\[placement\]/d' /etc/nova/nova.conf
sudo sed -i '/\[oslo_concurrency\]/d' /etc/nova/nova.conf
sudo sed -i '/\[libvirt\]/d' /etc/nova/nova.conf
sudo sed -i '/\[service_user\]/d' /etc/nova/nova.conf

sudo echo \
"[DEFAULT]
transport_url = rabbit://openstack:"$password"@controller:5672/
log_dir = /var/log/nova
lock_path = /var/lock/nova
state_path = /var/lib/nova
my_ip = "$ip""\
>> /etc/nova/nova.conf

sudo echo \
"[api]
auth_strategy = keystone"\
>> /etc/nova/nova.conf


sudo echo \
"[keystone_authtoken]
www_authenticate_uri = http://controller:5000/
auth_url = http://controller:5000/
memcached_servers = controller:11211
auth_type = password
project_domain_name = Default
user_domain_name = Default
project_name = service
username = nova
password = "$password""\
>> /etc/nova/nova.conf

sudo echo \
"[vnc]
enabled = true
server_listen = 0.0.0.0
novncproxy_base_url = http://controller:6080/vnc_auto.html
server_proxyclient_address = "$ip""\
>> /etc/nova/nova.conf

sudo echo \
"[glance]
api_servers = http://controller:9292"\
>> /etc/nova/nova.conf

sudo echo \
"[oslo_concurrency]
lock_path = /var/lib/nova/tmp"\
>> /etc/nova/nova.conf

sudo echo \
"[placement]
region_name = RegionOne
project_domain_name = Default
project_name = service
auth_type = password
user_domain_name = Default
auth_url = http://controller:5000/v3
username = placement
password = "$password""\
>> /etc/nova/nova.conf

sudo echo \
"[libvirt]
cpu_mode = host-passthrough"\
>> /etc/nova/nova.conf


sudo service nova-compute restart
