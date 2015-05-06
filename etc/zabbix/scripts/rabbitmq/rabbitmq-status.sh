#!/bin/bash
#
# https://github.com/jasonmcintosh/rabbitmq-zabbix
#
#UserParameter=rabbitmq[*],<%= zabbix_script_dir %>/rabbitmq-status.sh
cd "$(dirname "$0")"


TYPE_OF_CHECK=$1
METRIC=$2
NODE=$3
RABBITMQ_HOSTNAME=$4
RABBITMQ_USERNAME=$5
RABBITMQ_PASSWORD=$6

#rabbitmq[queues]
#rabbitmq[server,disk_free]

# This assumes that the server is going to then use zabbix_sender to feed the data BACK to the server.  Right now, I'm doing that
# in the python script

./api.py --hostname=$RABBITMQ_HOSTNAME --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD --check=$TYPE_OF_CHECK --metric=$METRIC --node="$NODE" --filters="$FILTER" --conf=$CONF
