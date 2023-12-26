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

## Glance
### Controller
Crea password per il DB.

```bash
sudo ./glance_1.sh root
```
Crea utente e scegli nuova password
```bash
openstack user create --domain default --password-prompt glance
```

Esegui senza sudo! Usa la password scelta al passo precedente
```bash
./glance_2.sh root 
```

```bash
sudo ./glance_3.sh root 
```


