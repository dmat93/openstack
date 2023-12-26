ls
touch nova_1.sh
touh nova2.sh
touch nova_2.sh
touch nova_3.sh
chmod +x nova_1.sh 
chmod +x nova_2.sh 
chmod +x nova_3.sh 
nano nova_1.sh 
sudo ./nova_1.sh 
openstack user create --domain default --password-prompt nova
. admin-openrc 
openstack user create --domain default --password-prompt nova
nano nova_2.sh 
./nova_2.sh 
sudo nan /etc/nova/nova.conf
sudo nano /etc/nova/nova.conf
sudo nan /etc/nova/nova.conf
sudo nano /etc/nova/nova.conf
nano nova_3.sh 
sudo ./nova_3.sh 
sudo nano /etc/nova/nova.conf
sudo ./nova_3.sh 
sudo nano /etc/nova/nova.conf
nano nova_3.sh 
sudo ./nova_3.sh 
. admin-openrc 
openstack compute service list --service nova-compute
openstack compute service list --service nova
openstack compute service list --service nova-api
cat /etc/hosts
sudo ./nova_3.sh 
nano nova_3.sh 
openstack compute service list --service nova-compute
. admin-openrc 
openstack compute service list --service nova-compute
ls
cat keystone.sh 
sudo nano /etc/hosts
ls
touch net.sh
chmod +x net.sh 
nano net.sh 
sudo ./net.sh 
touch chrony.sh
chmod +x chrony.sh 
nano cr
sudo ./chrony.sh 
add-apt-repository cloud-archive:wallaby
sudo add-apt-repository cloud-archive:wallaby
sudo nano mysql.sh
chmod +x mysql.sh 
ls
chmod +x mysql.sh 
sudo chmod +x mysql.sh 
suod ./mysql.sh 
sudo ./mysql.sh 
sudo mysql_secure_installation
touch rabbitmq.sh
nano rabbitmq.sh 
chmod +x rabbitmq.sh 
sudo ./rabbitmq.sh 
ls
rm cr
touch memcached.sh
nano memcached.sh 
chmod +x memcached.sh 
sudo ./memcached.sh 
touch etcd.sh
ls
nano etcd.sh 
chmod +x etcd.sh 
sudo ./etcd.sh 
ls
touch keystone.sh
nano keystone.sh 
chmod +x keystone.sh 
sudo ./keystone.sh 
ls
cat keystone.sh 
sudo cat /etc/keystone/keystone.conf
sudo openstack --os-auth-url http://controller:5000/v3 --os-project-domain-name Default --os-user-domain-name Default --os-project-name admin --os-username admin token issue
openstack --os-auth-url http://controller:5000/v3 --os-project-domain-name Default --os-user-domain-name Default --os-project-name admin --os-username admin token issue
ls
touch glance_1.sh
touch glance_2.sh
touch glance_3.sh
chmod +x glance_1.sh
chmod +x glance_2.sh
chmod +x glance_3.sh
nano glance_1.sh 
./glance_1.sh 
openstack user create --domain default --password-prompt glance
. admin-openrc 
openstack user create --domain default --password-prompt glance
nano glance_2.sh 
./glance_2.sh 
nano glance_3.sh 
sudo ./glance_3.sh 
sudo cat /etc/glance/glance-api.conf
sudo nano /etc/glance/glance-api.conf
nano glance_3.sh 
sudo ./glance_3.sh 
touch glance_4.sh
nano glance_4.sh 
chmod +x glance_4.sh 
./glance_4
./glance_4.sh 
wget http://download.cirros-cloud.net/
ls
rm index.html 
wget http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
ls
glance image-create --name "cirros" --file cirros-0.5.1-x86_64-disk.img --disk-format qcow2 --container-format bare --visibility=public
glance image-list  
touch placement_1.sh
touch placement_2.sh
touch placement_3.sh
chmod +x  placement_1.sh 
chmod +x  placement_2.sh 
chmod +x  placement_3.sh 
nano placement_1.sh 
sudo ./placement_1.sh 
. admin-openrc 
openstack user create --domain default --password-prompt placement
nano placement_2.sh 
./placement_2.sh 
nano placement_3.sh 
sudo ./placement_3.sh 
sudo cat /etc/placement/placement.conf
nano placement_3.sh 
sudo cat /etc/glance/glance-api.conf
sudo nano /etc/glance/glance-api.conf
sudo ./placement_3.sh 
sudo placement-status upgrade check
ls
touch neutron_1.sh
touch neutron_2.sh
touch neutron_3.sh
chmod +x neutron_1.sh
chmod +x neutron_2.sh
chmod +x neutron_3.sh
nano neutron_1.sh 
nano neutron_2.sh 
sudo ./neutron_1.sh 
. admin-openrc 
openstack user create --domain default --password-prompt neutron
./neutron_2.sh 
ls
nano neutron_2.sh 
sudo nano /etc/neutron/neutron.conf
sudo nano /etc/neutron/plugins/ml2/ml2_conf.ini
sudo nano /etc/neutron/plugins/ml2/linuxbridge_agent.ini
sudo nano /etc/neutron/l3_agent.ini
sudo nano /etc/neutron/dhcp_agent.ini
sudo nano /etc/neutron/metadata_agent.ini
sudo nano /etc/nova/nova.conf 
ip a
nano neutron_3.sh 
sudo ./neutron_3.sh 
sudo nano /etc/neutron/neutron.conf:
sudo nano /etc/neutron/neutron.conf
sudo su -s /bin/sh -c "neutron-db-manage --config-file /etc/neutron/neutron.conf --config-file /etc/neutron/plugins/ml2/ml2_conf.ini upgrade head" neutron
sudo service nova-api restart
sudo service neutron-server restart
sudo service neutron-linuxbridge-agent restart
sudo service neutron-dhcp-agent restart
sudo service neutron-metadata-agent restart
sudo service neutron-l3-agent restart
ls
nano neutron_3.sh 
