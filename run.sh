#!/bin/sh

HOSTNAME="$1"
SERVER="$2"

if [ -z "$HOSTNAME" ]; then
    echo "Hostname is missing"
    exit 1
fi

if [ -z "$SERVER" ]; then
    echo "Server is missing"
    exit 1
fi

mkdir -p /host/{proc,dev,sys}
mkdir -p /host/var/run/

sed -i "s/^Hostname\=.*/Hostname\=$HOSTNAME/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^Server\=.*/Server\=$SERVER/" /etc/zabbix/zabbix_agentd.conf
sed -i "s/^ServerActive\=.*/ServerActive\=$SERVER/" /etc/zabbix/zabbix_agentd.conf

sed -i "s/^MYSQL_PORT\=.*/MYSQL_PORT\=$MYSQL_PORT/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-mysql.conf
sed -i "s/^MYSQL_USER\=.*/MYSQL_USER\=$MYSQL_USER/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-mysql.conf
sed -i "s/^MYSQL_PASSWORD\=.*/MYSQL_PASSWORD\=$MYSQL_PASSWORD/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-mysql.conf
sed -i "s/^MYSQL_HOST\=.*/MYSQL_HOST\=$MYSQL_HOST/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-mysql.conf

sed -i "s/^RABBITMQ_HOSTNAME\=.*/RABBITMQ_HOSTNAME\=$RABBITMQ_HOSTNAME/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-rabbitmq.conf
sed -i "s/^RABBITMQ_USERNAME\=.*/RABBITMQ_USERNAME\=$RABBITMQ_USERNAME/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-rabbitmq.conf
sed -i "s/^RABBITMQ_PASSWORD\=.*/RABBITMQ_PASSWORD\=$RABBITMQ_PASSWORD/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-rabbitmq.conf

sed -i "s/^REDIS_HOSTNAME\=.*/REDIS_HOSTNAME\=$REDIS_HOSTNAME/" /etc/zabbix/zabbix_agentd.conf.d/zabbix-redis.conf

service zabbix-agent start
exec /usr/bin/supervisord

