#!/bin/sh
openstack project create --domain default --description "Service Project" service
openstack role add --project service --user glance admin
