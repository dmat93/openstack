#!/bin/sh
INTERFACE_NAME=$1

echo \
"auto $INTERFACE_NAME
iface $INTERFACE_NAME inet manual
up ip link set dev $INTERFACE_NAME up
down ip link set dev $INTERFACE_NAME down" \
> /etc/network/interfaces

