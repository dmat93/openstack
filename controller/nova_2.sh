#!/bin/sh
ip_controller=$1
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne compute public http://$ip_controller:8774/v2.1
openstack endpoint create --region RegionOne compute internal http://$ip_controller:8774/v2.1
openstack endpoint create --region RegionOne compute admin http://$ip_controller:8774/v2.1

sudo apt install nova-api nova-conductor nova-novncproxy nova-scheduler -y
