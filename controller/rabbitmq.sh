#!/bin/sh
RABBIT_PASS=`cat RABBIT_PASS`

sudo apt install rabbitmq-server -y
sudo rabbitmqctl add_user openstack $RABBIT_PASS
sudo rabbitmqctl set_permissions openstack ".*" ".*" ".*"
