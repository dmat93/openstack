#!/bin/sh
password=$1
ip=$2

sudo sed -i '/connection = sqlite/d' /etc/neutron/neutron.conf
sudo sed -i '/core_plugin = ml2/d' /etc/neutron/neutron.conf
sudo sed -i '/\[keystone_authtoken\]/d' /etc/neutron/neutron.conf
sudo sed -i '/\[database\]/d' /etc/neutron/neutron.conf
sudo sed -i '/\[DEFAULT\]/d' /etc/neutron/neutron.conf
sudo sed -i '/connection = sqlite/d' /etc/neutron/neutron.conf
sudo sed -i '/\[nova\]/d' /etc/neutron/neutron.conf
sudo sed -i '/\[oslo_concurrency\]/d' /etc/neutron/neutron.conf
ssudo sed -i '/\[experimental\]/d' /etc/neutron/neutron.conf

sudo echo \
"[DEFAULT]
transport_url = rabbit://openstack:"$password"@"$ip"/
core_plugin = ml2
service_plugins = router
allow_overlapping_ips = true
auth_strategy = keystone
notify_nova_on_port_status_changes = true
notify_nova_on_port_data_changes = true"\
>> /etc/neutron/neutron.conf

sudo echo \
"[nova]
auth_url = http://"$ip":5000
auth_type = password
project_domain_name = default
user_domain_name = default
region_name = RegionOne
project_name = service
username = nova
password = "$password""\
>> /etc/neutron/neutron.conf


sudo echo \
"[keystone_authtoken]
www_authenticate_uri = http://"$ip":5000
auth_url = http://"$ip":5000
memcached_servers = "$ip":11211
auth_type = password
project_domain_name = default
user_domain_name = default
project_name = service
username = neutron
password = "$password""\
>> /etc/neutron/neutron.conf

sudo echo \
"[database]
connection = mysql+pymysql://neutron:"$password"@controller/neutron"\
>> /etc/neutron/neutron.conf

sudo echo \
"[experimental]
linuxbridge = true"\
>> /etc/neutron/neutron.conf


sudo echo \
"[oslo_concurrency]
lock_path = /var/lib/neutron/tmp"\
>> /etc/neutron/neutron.conf


sudo sed -i '/\[ml2\]/d' /etc/neutron/plugins/ml2/ml2_conf.ini
sudo sed -i '/\[ml2_type_flat\]/d' /etc/neutron/plugins/ml2/ml2_conf.ini
sudo sed -i '/\[ml2_type_vxlan\]/d' /etc/neutron/plugins/ml2/ml2_conf.ini
sudo sed -i '/\[securitygroup\]/d' /etc/neutron/plugins/ml2/ml2_conf.ini

sudo echo \
"[ml2]
type_drivers = flat,vlan,vxlan 
tenant_network_types = vxlan
mechanism_drivers = linuxbridge,l2population
extension_drivers = port_security"\
>> /etc/neutron/plugins/ml2/ml2_conf.ini

sudo echo \
"[ml2_type_flat]
flat_networks = provider"\
>> /etc/neutron/plugins/ml2/ml2_conf.ini

sudo echo \
"[ml2_type_vxlan]
vni_ranges = 1:1000"\
>> /etc/neutron/plugins/ml2/ml2_conf.ini

sudo echo \
"[securitygroup]
enable_ipset = true"\
>> /etc/neutron/plugins/ml2/ml2_conf.ini


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


sudo sed -i '/\[DEFAULT\]/d'  /etc/neutron/l3_agent.ini
sudo echo \
"[DEFAULT]
interface_driver = linuxbridge"\
>> /etc/neutron/l3_agent.ini


sudo sed -i '/\[DEFAULT\]/d'  /etc/neutron/dhcp_agent.ini
sudo echo \
"[DEFAULT]
interface_driver = linuxbridge
dhcp_driver = neutron.agent.linux.dhcp.Dnsmasq
enable_isolated_metadata = true"\
>> /etc/neutron/dhcp_agent.ini

sudo sed -i '/\[DEFAULT\]/d'  /etc/neutron/metadata_agent.ini
sudo echo \
"[DEFAULT]
nova_metadata_host = controller
metadata_proxy_shared_secret = "$password""\
>> /etc/neutron/metadata_agent.ini

sudo sed -i '/\[neutron\]/d'  /etc/nova/nova.conf
sudo echo \
"[neutron]
auth_url = http://"$ip":5000
auth_type = password
project_domain_name = default
user_domain_name = default
region_name = RegionOne
project_name = service
username = neutron
password = "$password"
service_metadata_proxy = true
metadata_proxy_shared_secret = "$password""\
>> /etc/nova/nova.conf


sudo su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron

sudo service nova-api restart 
sudo service neutron-server restart
sudo service neutron-linuxbridge-agent restart
sudo service neutron-dhcp-agent restart
sudo service neutron-metadata-agent restart
sudo service neutron-l3-agent restart
