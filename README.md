# GUIDA
Tested on Ubuntu 22.04.3 LTS. Make sure all machines have this version of ubuntu, otherwise compute discovery may not work.

### COMPUTE E CONTROLLER
Use the zed verisone

```bash
sudo add-apt-repository cloud-archive:zed
```
## Generate passwords
Use the following script to generate passwords to be used during the installation. Files will be created in the local folder.
```bash
./generate_passwords.sh
```

## Network configuration
### COMPUTE and CONTROLLER
Edit */etc/hosts* by commenting out the line containing 127.0.1.1 and adding ip and controller/compute hosts

```bash

#127.0.1.1 controller

# controller
192.168.123.150       controller
# compute1
192.168.123.177       compute1
# compute2
192.168.123.227       compute2

```

## Chrony
### COMPUTE and CONTROLLER
Add the CIDR of the managment network.

```bash
sudo ./controller/chrony.sh 192.168.123.0/24
```

## Mysql
### Controller
Add controller ip

```bash
sudo ./controller/mysql.sh <ip-controller>
```

## RabbitMQ
### Controller
Create rabbit password

```bash
sudo ./controller/rabbitmq.sh
```

## Memcache
### Controller
Add ip controller

```bash
sudo ./controller/memcached.sh <ip-controller>
```

## ETCD
### Controller
Aggiungi ip controller

```bash
sudo ./controller/etcd.sh <ip-controller>
```
## Keystone
### Controller
It may take a few minutes!

```bash
sudo ./controller/keystone.sh <ip-controller>
```

Verify that everything went well. 

```bash
. admin-openrc
openstack --os-auth-url http://controller:5000/v3 \
--os-project-domain-name Default --os-user-domain-name Default \
--os-project-name admin --os-username admin token issue
```

If the output is like that then okay:

```bash
+------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Field      | Value                                                                                                                                                                                   |
+------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| expires    | 2023-12-28T13:46:02+0000                                                                                                                                                                |
| id         | gAAAAABljW4KfD0NvTZ2rtuL5k7y4qSben7IkBH5s5ZnsL7-kYlqH5TT9EbX2WgBTkUJ5_DletQcc8fEX0s0h3vEqwqZY3AwrDXeDLNpbCWVdthGcSp6Qx1YNw7qplmtv4EutUP4OnDdjqrrK29Ds_0XzbfyR6KcPrcWyjRJ--wPAVaHKt-Z-bw |
| project_id | 142934028dd840a4b6271b2c41c88446                                                                                                                                                        |
| user_id    | 22dbbad875564745965295fd5ef90e63                                                                                                                                                        |
+------------+-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
```

## Glance
### Controller

```bash
sudo ./controller/glance_1.sh
```
Create user.
```bash
# The password GLANCE_PASS is used
openstack user create --domain default --password `cat GLANCE_PASS` glance
```

Run without sudo! 
```bash
./controller/glance_2.sh <ip-controller>
```

Run with sudo! 

```bash
sudo ./controller/glance_3.sh <ip-controller>
```
Run without sudo!

```bash
./controller/glance_4.sh  
```

#### Testing
```bash
wget http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
glance image-create --name "cirros" --file cirros-0.5.1-x86_64-disk.img --disk-format qcow2 --container-format bare --visibility=public 
```

If the output is like that then OK:

```bash
+------------------+----------------------------------------------------------------------------------+
| Property         | Value                                                                            |
+------------------+----------------------------------------------------------------------------------+
| checksum         | 1d3062cd89af34e419f7100277f38b2b                                                 |
| container_format | bare                                                                             |
| created_at       | 2023-12-26T14:35:24Z                                                             |
| disk_format      | qcow2                                                                            |
| id               | f5a445c3-ec48-48e7-af06-cb9a626d6955                                             |
| min_disk         | 0                                                                                |
| min_ram          | 0                                                                                |
| name             | cirros                                                                           |
| os_hash_algo     | sha512                                                                           |
| os_hash_value    | 553d220ed58cfee7dafe003c446a9f197ab5edf8ffc09396c74187cf83873c877e7ae041cb80f3b9 |
|                  | 1489acf687183adcd689b53b38e3ddd22e627e7f98a09c46                                 |
| os_hidden        | False                                                                            |
| owner            | 80abe5a69b814a3cbbf66b05a74187fa                                                 |
| protected        | False                                                                            |
| size             | 16338944                                                                         |
| status           | active                                                                           |
| tags             | []                                                                               |
| updated_at       | 2023-12-26T14:35:24Z                                                             |
| virtual_size     | 117440512                                                                        |
| visibility       | public                                                                           |
+------------------+----------------------------------------------------------------------------------+
```
## Placement
### Controller
```bash
sudo ./controller/placement_1.sh
```

Create the user

```bash
# Password PLACEMENT_PASS is used 
openstack user create --domain default --password `cat PLACEMENT_PASS` placement
```

Run (Without sudo!) by entering the previously created password

```bash
./controller/placement_2.sh <ip-controller>
```

Run (With sudo!) 
```bash
sudo ./controller/placement_3.sh <ip-controller>
```

#### Testing
```bash
sudo placement-status upgrade check
```
If the output is like this then ok
```bash
+-------------------------------------------+
| Upgrade Check Results                     |
+-------------------------------------------+
| Check: Missing Root Provider IDs          |
| Result: Success                           |
| Details: None                             |
+-------------------------------------------+
| Check: Incomplete Consumers               |
| Result: Success                           |
| Details: None                             |
+-------------------------------------------+
| Check: Policy File JSON to YAML Migration |
| Result: Success                           |
| Details: None                             |
+-------------------------------------------+
```

## Nova
### Controller

```bash
sudo ./controller/nova_1.sh
```

Create the user

```bash
# The password NOVA_PASS is used
openstack user create --domain default --password `cat NOVA_PASS` nova
```

Run (Without sudo!) by entering the previously created password

```bash
./controller/nova_2.sh <ip-controller>
```

Run (With sudo!) 
```bash
sudo ./controller/nova_3.sh <ip-controller>
```
### Compute
Specifies the IP of **compute**
```bash
sudo ./compute/nova.sh <ip-compute>  
```
### Controller
Discovery of computes.

```bash
sudo su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
openstack compute service list
```
The output should look like:

```bash
+--------------------------------------+----------------+------------+----------+---------+-------+----------------------------+
| ID                                   | Binary         | Host       | Zone     | Status  | State | Updated At                 |
+--------------------------------------+----------------+------------+----------+---------+-------+----------------------------+
| 05a2ff70-c99e-4efb-b338-b2d608f60757 | nova-scheduler | controller | internal | enabled | up    | 2023-12-26T15:11:43.000000 |
| 669048ce-ce47-48f0-9b1f-e8744e08f683 | nova-conductor | controller | internal | enabled | up    | 2023-12-26T15:11:43.000000 |
| 80c1e4ab-aab1-4013-9531-af0b91132ca3 | nova-compute   | compute1   | nova     | enabled | up    | 2023-12-26T15:11:43.000000 |
+--------------------------------------+----------------+------------+----------+---------+-------+----------------------------+

```

## Neutron
### Controller
```bash
sudo ./controller/neutron_1.sh 
```

Create the user
```bash
# The password NEUTRON_PASS is used
openstack user create --domain default --password `cat NEUTRON_PASS` neutron
```

Run (Without sudo!) 

```bash
./controller/neutron_2.sh <ip-controller>
```

Run (With sudo!) 
```bash
sudo ./controller/neutron_3.sh <ip-controller>
```
### Compute
Specificy the IP of the **compute**
```bash
sudo ./compute/neutron.sh <ip-compute>
```

### Testing
Run on the controller
```bash
openstack network agent list
```

If the output is like that then okay:
```bash
+--------------------------------------+--------------------+------------+-------------------+-------+-------+---------------------------+
| ID                                   | Agent Type         | Host       | Availability Zone | Alive | State | Binary                    |
+--------------------------------------+--------------------+------------+-------------------+-------+-------+---------------------------+
| 11bfa343-0089-4fa7-8d80-32da140cd0ac | Linux bridge agent | controller | None              | :-)   | UP    | neutron-linuxbridge-agent |
| 712406b4-c480-4043-8c49-9a9abcea85a9 | DHCP agent         | controller | nova              | :-)   | UP    | neutron-dhcp-agent        |
| 73cf6d54-bf5c-490c-b685-7532b56eb10e | Linux bridge agent | compute1   | None              | :-)   | UP    | neutron-linuxbridge-agent |
| c573aed7-43da-43a1-97c6-c27569f01843 | Metadata agent     | controller | None              | :-)   | UP    | neutron-metadata-agent    |
+--------------------------------------+--------------------+------------+-------------------+-------+-------+---------------------------+

```
## Horizon
### Controller
```bash
sudo apt install openstack-dashboard -y
```
Add the following lines to `/etc/openstack-dashboard/local_settings.py` commenting on existing ones:

```bash

#Metti ip del controller
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '<replace-with-ip-controller>:11211',
    },
}


OPENSTACK_HOST = "<replace-with-ip-controller>"
OPENSTACK_KEYSTONE_URL = "http://%s:5000/v3" % OPENSTACK_HOST

OPENSTACK_KEYSTONE_MULTIDOMAIN_SUPPORT = True

OPENSTACK_API_VERSIONS = {
    "identity": 3,
    "image": 2,
    "volume": 3,
}

OPENSTACK_KEYSTONE_DEFAULT_DOMAIN = "Default"

OPENSTACK_KEYSTONE_DEFAULT_ROLE = "member"

TIME_ZONE = "Europe/Rome"
```
Add the following line to `/etc/apache2/conf-available/openstack-dashboard.conf` (if necessary):
```bash
WSGIApplicationGroup %{GLOBAL}
```

```bash
sudo systemctl reload apache2.service
```

Go to `http://192.168.123.150/horizon` to access and test.


## Rete fisica <mark> TODO </mark>
### Controller
Esegui esattamente questo comando
```bash
openstack network create --share --external --provider-physical-network provider --provider-network-type flat provider
```
Esegui questo comando sostituiendo a **192.168.123** l'indirizzo di sottorete di menagment in cui sono i compute e il controller
```bash
openstack subnet create --network provider \
--allocation-pool start=192.168.123.10,end=192.168.123.100 \
--dns-nameserver 8.8.8.8 --gateway 192.168.123.1 \
--subnet-range 192.168.123.0/24 provider
```

Sostituisci selfservice con il nome che preferisci
```bash
openstack network create selfservice
```

Sostituisci (se vuoi) l'indirizzo di sottorete che preferisci. Puoi lanciare questo comando anche così.
```bash
openstack subnet create --network selfservice \
--dns-nameserver 8.8.4.4 --gateway 172.16.1.1 \
--subnet-range 172.16.1.0/24 selfservice
```

```bash
openstack router create router
```

```bash
openstack router add subnet router selfservice
```

```bash
openstack router set router --external-gateway provider
```








