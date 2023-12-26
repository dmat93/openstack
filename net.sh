#!/bin/sh
INTERFACE_NAME="enp1s0"

echo \
"auto $INTERFACE_NAME
iface $INTERFACE_NAME inet manual
up ip link set dev $IFACE up
down ip link set dev $IFACE down" \
> /etc/network/interfaces

