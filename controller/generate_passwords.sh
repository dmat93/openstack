#!/bin/sh
passwords=(KEYSTONE_ADMIN_PASS \
    RABBIT_PASS \
    GLANCE_PASS \ 
    PLACEMENT_PASS \
    NOVA_PASS \
    NEUTRON_PASS \
    METADATA_SECRET)
for i in ${passwords[@]}
do 
    openssl rand -hex 10 > $i
done

for i in ${passwords[@]}
do 
    cat $i
done

