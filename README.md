# GUIDA
Testato su Ubuntu 22.04.3 LTS. Assicurati che tutte le macchine abbiano questa versione di ubuntu, altrimenti potrebbe non funzionare il discovery dei compute.

### COMPUTE E CONTROLLER
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

sudo ./controller/net.sh enp1s0

```

## Chrony
### COMPUTE E CONTROLLER
Aggiungi il cidr della rete di managment

```bash

sudo ./controller/chrony.sh 192.168.123.0/24

```

## Mysql
### Controller
Aggiungi ip del controller

```bash
sudo ./controller/mysql.sh 192.168.123.150
```

## RabbitMQ
### Controller
Crea password rabbit

```bash
sudo ./controller/rabbitmq.sh root
```

## Memcache
### Controller
Aggiungi ip controller

```bash
sudo ./controller/memcached.sh 192.168.123.150
```

## ETCD
### Controller
Aggiungi ip controller

```bash
sudo ./controller/etcd.sh 192.168.123.150
```
## Keystone
### Controller
Crea password e passa ip controller. Potrebbe richiedere qualche minuto!

```bash
sudo ./controller/keystone.sh root 192.168.123.150
```

Verifica che tutto sia andato bene. 

```bash
. admin-openrc
openstack --os-auth-url http://controller:5000/v3 \
--os-project-domain-name Default --os-user-domain-name Default \
--os-project-name admin --os-username admin token issue
```

Se l'output è cosi allora ok:

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
Crea password per il DB.

```bash
sudo ./controller/glance_1.sh root
```
Crea utente e scegli nuova password. Si aprirà una schermata in cui ti chiede di creare una nuova password.
```bash
openstack user create --domain default --password-prompt glance
```

Esegui senza sudo! Usa la password scelta al passo precedente
```bash
./controller/glance_2.sh root 192.168.123.150
```

Esegui con sudo! Usa la password scelta al passo precedente

```bash
sudo ./controller/glance_3.sh root 192.168.123.150
```
Esegui senza sudo!

```bash
./controller/glance_4.sh  
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
sudo ./controller/placement_1.sh root
```

Si aprirà una schermata da cui creare una nuova password

```bash
openstack user create --domain default --password-prompt placement
```

Eseguire (Senza sudo!) inserendo la password creata precedentemente

```bash
./controller/placement_2.sh 192.168.123.150
```

Eseguire (Con sudo!) inserendo la password creata precedentemente e l'ip del controller
```bash
sudo ./controller/placement_3.sh root 192.168.123.150
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
sudo ./controller/nova_1.sh root
```

Si aprirà una schermata da cui creare una nuova password

```bash
openstack user create --domain default --password-prompt nova
```

Eseguire (Senza sudo!) inserendo la password creata precedentemente

```bash
./controller/nova_2.sh 192.168.123.150
```

Eseguire (Con sudo!) inserendo la password creata precedentemente e l'ip del controller
```bash
sudo ./controller/nova_3.sh root 192.168.123.150
```
### Compute
Specifica password creata in precedenza e ip del **compute**
```bash
sudo ./compute/nova.sh 192.168.123.177 root 
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
sudo ./controller/neutron_1.sh root 
```

Si aprirà una schermata da cui creare una nuova password

```bash
openstack user create --domain default --password-prompt neutron
```

Eseguire (Senza sudo!) 

```bash
./controller/neutron_2.sh 192.168.123.150
```

Eseguire (Con sudo!) inserendo la password creata precedentemente e l'ip del controller
```bash
sudo ./controller/neutron_3.sh root 192.168.123.150
```
### Compute
Specifica password creata in precedenza e ip del **compute**
```bash
sudo ./compute/neutron.sh root 192.168.123.177
```

### Per testare
Esegui sul controller
```bash
openstack network agent list
```

Se l'output è cosi allora ok:
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
Aggiungi le seguenti righe a */etc/openstack-dashboard/local_settings.py* commentando quelle già esistenti:

```bash

#Metti ip del controller
CACHES = {
    'default': {
        'BACKEND': 'django.core.cache.backends.memcached.MemcachedCache',
        'LOCATION': '192.168.123.150:11211',
    },
}


OPENSTACK_HOST = "192.168.123.150"
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
Aggiungi la seguente riga a */etc/apache2/conf-available/openstack-dashboard.conf* (se necessario):
```bash
WSGIApplicationGroup %{GLOBAL}
```

```bash
sudo systemctl reload apache2.service
```

Ora vai a 192.168.123.150/horizon per accedere.


## Rete fisica
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








