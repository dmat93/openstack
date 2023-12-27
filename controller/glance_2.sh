#!/bin/sh

password=$1
ip_controller=$2
openstack role add --project Default --user glance admin
openstack service create --name glance --description "OpenStack Image" image
openstack endpoint create --region RegionOne image public http://$ip_controller:9292
openstack endpoint create --region RegionOne image internal http://$ip_controller:9292
openstack endpoint create --region RegionOne image admin http://$ip_controller:9292
