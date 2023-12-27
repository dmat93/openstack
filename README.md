# GUIDA

Utilizza la verisone zed

```bash

sudo add-apt-repository cloud-archive:zed

```
## Configurazione rete
### COMPUTE E CONTROLLER
Modifica */etc/hosts* commentando 127.0.1.1 controller

```bash

#127.0.1.1 controller

# controller
192.168.123.150       controller
# compute1
192.168.123.177       compute1
# compute2
192.168.123.227       compute2

```

Specifica l'interfaccia della rete di managment

```bash

sudo ./net.sh enp1s0

```

## Chrony
### Controller
Aggiungi il cidr della rete di managment

```bash

sudo ./chrony.sh 192.168.123.0/24

```
### Compute
```bash
sudo ./chrony.sh 192.168.123.0/24
```

## Mysql
### Controller
Aggiungi ip del controller

```bash
sudo ./mysql.sh 192.168.123.150
```

## RabbitMQ
### Controller
Crea password rabbit

```bash
sudo ./rabbitmq.sh root
```

## Memcache
### Controller
Aggiungi ip controller

```bash
sudo ./memcached.sh 192.168.123.150
```

## ETCD
### Controller
Aggiungi ip controller

```bash
sudo ./etcd.sh 192.168.123.150
```
## Keystone
### Controller
Crea password. Potrebbe richiedere qualche minuto!

```bash
sudo ./keystone.sh root
```

Verifica che tutto sia andato bene. Ti verrà chiesta un password, inserisc quella creata al passo precedente.

```bash
. admin-openrc
openstack --os-auth-url http://controller:5000/v3 \
--os-project-domain-name Default --os-user-domain-name Default \
--os-project-name admin --os-username admin token issue
```

## Glance
### Controller
Crea password per il DB.

```bash
sudo ./glance_1.sh root
```
Crea utente e scegli nuova password. Si aprirà una schermata in cui ti chiede di creare una nuova password.
```bash
openstack user create --domain default --password-prompt glance
```

Esegui senza sudo! Usa la password scelta al passo precedente
```bash
./glance_2.sh  
```

Esegui con sudo! Usa la password scelta al passo precedente

```bash
sudo ./glance_3.sh root 
```
Esegui senza sudo!

```bash
./glance_4.sh 
```

#### Per testare
```bash
wget http://download.cirros-cloud.net/0.5.1/cirros-0.5.1-x86_64-disk.img
glance image-create --name "cirros" --file cirros-0.5.1-x86_64-disk.img --disk-format qcow2 --container-format bare --visibility=public 
```

Se l'output è cosi allora OK:

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
Crea password per il DB.

```bash
sudo ./placement_1.sh root
```

Si aprirà una schermata da cui creare una nuova password

```bash
openstack user create --domain default --password-prompt placement
```

Eseguire (Senza sudo!) inserendo la password creata precedentemente

```bash
./placement_2.sh 
```

Eseguire (Con sudo!) inserendo la password creata precedentemente
```bash
sudo ./placement_3.sh root
```

#### Per testare
```bash
sudo placement-status upgrade check
```
Se l'output è cosi allora ok
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
Crea password per il DB.

```bash
sudo ./nova_1.sh root

Si aprirà una schermata da cui creare una nuova password

```bash
openstack user create --domain default --password-prompt nova
```

Eseguire (Senza sudo!) inserendo la password creata precedentemente

```bash
./nova_2.sh
```

Eseguire (Con sudo!) inserendo la password creata precedentemente e l'ip del controller
```bash
sudo ./nova_3.sh root 192.168.123.150
```
### Compute
Specifica password creata in precedenza e ip del compute
```bash
sudo ./nova.sh root 192.168.123.177
```
### Controller
Discovery dei compute.

```bash
sudo su -s /bin/sh -c "nova-manage cell_v2 discover_hosts --verbose" nova
openstack compute service list
```
L'output dovrebbe essere simile a:

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
Crea password per il DB.

```bash
sudo ./neutron_1.sh root 
```

Si aprirà una schermata da cui creare una nuova password

```bash
openstack user create --domain default --password-prompt neutron
```

Eseguire (Senza sudo!) 

```bash
./neutron_2.sh
```

Eseguire (Con sudo!) inserendo la password creata precedentemente e l'ip del controller
```bash
sudo ./neutron_3.sh root 192.168.123.150
```
### Compute
Specifica password creata in precedenza e ip del compute
```bash
sudo ./neutron.sh root 192.168.123.177
```

