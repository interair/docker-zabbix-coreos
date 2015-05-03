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
service zabbix-agent start
exec /usr/bin/supervisord

