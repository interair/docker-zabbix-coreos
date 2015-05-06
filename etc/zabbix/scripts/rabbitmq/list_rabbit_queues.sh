#!/bin/bash

cd "$(dirname "$0")"
. ../conf/rabbimq.conf

./api.py --hostname=$RABBITMQ_HOSTNAME --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD --check=list_queues --filter="$FILTER" --conf=$CONF