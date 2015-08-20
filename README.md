# Docker Zabbix agent#

This Docker container provides a patched Zabbix agent to monitor a real server and all his containers.
It's monitor docker via python api
+ It has scripts for monitoring rabbitMQ (via python + HTTP API)  https://github.com/jasonmcintosh/rabbitmq-zabbix


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