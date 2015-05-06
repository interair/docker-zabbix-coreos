#!/bin/bash
#
# https://github.com/jasonmcintosh/rabbitmq-zabbix
#
cd "$(dirname "$0")"

RABBITMQ_HOSTNAME=$1
RABBITMQ_USERNAME=$2
RABBITMQ_PASSWORD=$3

./api.py --hostname=$RABBITMQ_HOSTNAME --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD --check=list_queues --filter="$FILTER" --conf=$CONF