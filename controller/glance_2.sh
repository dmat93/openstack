#!/bin/sh

GLANCE_PASS=`cat GLANCE_PASS`
ip_controller=$1

openstack role add --project Default --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://$ip_controller:9292
openstack endpoint create --region RegionOne image internal http://$ip_controller:9292
openstack endpoint create --region RegionOne image admin http://$ip_controller:9292
