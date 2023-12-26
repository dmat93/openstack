#!/bin/sh
ip_controller=$1

apt install memcached python3-memcache -y
sudo sed -i '/^-l 127.0.0.1/d' /etc/memcached.conf
echo "-l $ip_controller" >/etc/memcached.conf
echo "-u controller" >>/etc/memcached.conf
service memcached restart
