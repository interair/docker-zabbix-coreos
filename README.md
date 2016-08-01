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
         wddocker.mapbar.com/docker-zabbix-agent <zabbix-agent-host-name> zabbix-server

```

### Server side installation ###
TODO: automate this

1.Login to the web (Admin/zabbix)
2.Navigate to "Configuration"->"Hosts" and push "Import" button

![zabbix_configuration.png](https://raw.githubusercontent.com/interair/docker-zabbix-agent/master/img/zabbix_configuration.png)

3.Import files from [/etc/zabbix/templates](https://github.com/interair/docker-zabbix-agent/tree/master/etc/zabbix/templates) :

* Import zbx_3rd_party_apps_host.xml or zbx_base_host.xml in last order 

4.Go to the settings->hosts and rename recently created host to appropriate name

5.The result will be:

![zabbix_result1.png](https://raw.githubusercontent.com/interair/docker-zabbix-agent/master/img/zabbix_result1.png)

**Monitoring->Latest data**

![zabbix_result2.png](https://raw.githubusercontent.com/interair/docker-zabbix-agent/master/img/zabbix_result2.png)

![zabbix_result5.png](https://raw.githubusercontent.com/interair/docker-zabbix-agent/master/img/zabbix_result5.png)

**Graphs**

![zabbix_result3.png](https://raw.githubusercontent.com/interair/docker-zabbix-agent/master/img/zabbix_result3.png)
