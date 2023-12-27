#!/bin/sh
ip=$1
openstack role add --project service --user placement admin
openstack service create --name placement --description "Placement API" placement
openstack endpoint create --region RegionOne placement public http://$ip:8778
openstack endpoint create --region RegionOne placement internal http://$ip:8778
openstack endpoint create --region RegionOne placement admin http://$ip:8778
sudo apt install placement-api
