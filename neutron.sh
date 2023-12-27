#!/bin/sh

password=$1
ip=$2
sudo apt install neutron-linuxbridge-agent -y

sudo sed -i '/connection = sqlite/d' /etc/neutron/neutron.conf
sudo sed -i '/core_plugin = ml2/d' /etc/neutron/neutron.conf
sudo sed -i '/\[DEFAULT\]/d' /etc/neutron/neutron.conf
sudo sed -i '/\[keystone_authtoken\]/d' /etc/neutron/neutron.conf
sudo sed -i '/\[oslo_concurrency\]/d' /etc/neutron/neutron.conf


sudo echo \
"[DEFAULT]
transport_url = rabbit://openstack:"$password"@controller
auth_strategy = keystone"\
>> /etc/neutron/neutron.conf

sudo echo \
"[keystone_authtoken]
www_authenticate_uri = http://controller:5000
auth_url = http://controller:5000
memcached_servers = controller:11211
auth_type = password
project_domain_name = default
user_domain_name = default
project_name = service
username = neutron
password = "$password""\
>> /etc/neutron/neutron.conf


sudo echo \
"[oslo_concurrency]
lock_path = /var/lib/neutron/tmp"\
>> /etc/neutron/neutron.conf


sudo sed -i '/\[linux_bridge\]/d' /etc/neutron/plugins/ml2/linuxbridge_agent.ini
sudo sed -i '/\[vxlan\]/d' /etc/neutron/plugins/ml2/linuxbridge_agent.ini
sudo sed -i '/\[securitygroup\]/d' /etc/neutron/plugins/ml2/linuxbridge_agent.ini

sudo echo \
"[linux_bridge]
physical_interface_mappings = provider:enp1s0"\
>> /etc/neutron/plugins/ml2/linuxbridge_agent.ini

sudo echo \
"[vxlan]
enable_vxlan = true
local_ip = "$ip"
l2_population = true"\
>> /etc/neutron/plugins/ml2/linuxbridge_agent.ini

sudo echo \
"[securitygroup]
enable_security_group = true
firewall_driver = neutron.agent.linux.iptables_firewall.IptablesFirewallDriver"\
>> /etc/neutron/plugins/ml2/linuxbridge_agent.ini

sysctl net.bridge.bridge-nf-call-iptables
sysctl net.bridge.bridge-nf-call-ip6tablesOVN


sudo sed -i '/\[neutron\]/d'  /etc/nova/nova.conf

sudo echo \
"[neutron]
auth_url = http://controller:5000
auth_type = password
project_domain_name = default
user_domain_name = default
region_name = RegionOne
project_name = service
username = neutron
password = "$password""\
>>   /etc/nova/nova.conf


sudo service nova-compute restart
sudo service neutron-linuxbridge-agent restart
