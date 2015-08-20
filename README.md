# Docker Zabbix agent#

This Docker container provides a patched Zabbix agent to monitor a real server and all his containers.
It's monitor docker via python api
It has additional scripts for monitoring:
* rabbitMQ (via python + HTTP API)  https://github.com/jasonmcintosh/rabbitmq-zabbix
* mysql
* redis

## Installation ##

### Zabbix agent installation: ###

```
#!shell
docker run -d -p 10050:10050 -v /proc:/host/proc -v /sys:/host/sys -v /sys/fs/cgroup:/sys/fs/cgroup  -v /dev:/host/dev -v /var/run/docker.sock:/var/run/docker.sock \
     --name zabbix-agent -h zabbix-agent \
     -e RABBITMQ_HOSTNAME="rabbitmq" -e RABBITMQ_USERNAME="admin" -e RABBITMQ_PASSWORD="opentsp" \
     -e MYSQL_HOST="mysql" -e MYSQL_PORT="3306" -e MYSQL_USER="admin" -e MYSQL_PASSWORD="opentsp" \
     -e REDIS_HOSTNAME="redis" \
     --dns-search=weave.local \
         wddocker.mapbar.com/docker-zabbix-agent zabbix-agent zabbix-server

```

### Server side installation ###
TODO: automate this

1. Login to the web (Admin/zabbix)
2. Navigate to "Configuration"->"Hosts" and push "Import" button

![zabbix_configuration.png](https://bitbucket.org/repo/MqG9eq/images/1581131486-zabbix_configuration.png)

3. Import files from [/etc/zabbix/templates](https://bitbucket.org/codeabovelab/ni-opentsp-zabbix-agent/src/master/etc/zabbix/templates/?at=master) :

* Import zbx_export_hosts.xml in last order
