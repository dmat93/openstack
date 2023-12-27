#!/bin/sh
ip_controller=$1
openstack role add --project service --user neutron admin
openstack service create --name neutron --description "OpenStack Networking" network
openstack endpoint create --region RegionOne network public http://$ip_controller:9696
openstack endpoint create --region RegionOne network internal http://$ip_controller:9696
openstack endpoint create --region RegionOne network admin http://$ip_controller:9696

sudo apt install neutron-server neutron-plugin-ml2 \
neutron-linuxbridge-agent neutron-l3-agent neutron-dhcp-agent \
neutron-metadata-agent -y
