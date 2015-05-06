#!/bin/bash
cd "$(dirname "$0")"
. ../conf/rabbitmq.conf

./api.py --hostname=$RABBITMQ_HOSTNAME --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD --check=list_nodes --filter="$FILTER" --conf=$CONF