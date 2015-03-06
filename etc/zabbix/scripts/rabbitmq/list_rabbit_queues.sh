#!/bin/bash
#
# https://github.com/jasonmcintosh/rabbitmq-zabbix
#
cd "$(dirname "$0")"
. .rab.auth
./api.py --hostname=$HOSTNAME --username=$USERNAME --password=$PASSWORD --check=list_queues --filter="$FILTER" --conf=$CONF