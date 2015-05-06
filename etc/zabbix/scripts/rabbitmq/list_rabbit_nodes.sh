#!/bin/bash
cd "$(dirname "$0")"

./api.py --hostname=$RABBITMQ_HOSTNAME --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD --check=list_nodes --filter="$FILTER" --conf=$CONF