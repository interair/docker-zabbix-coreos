#!/bin/bash
cd "$(dirname "$0")"

RABBITMQ_HOSTNAME=$1
RABBITMQ_USERNAME=$2
RABBITMQ_PASSWORD=$3

./api.py --hostname=$RABBITMQ_HOSTNAME --username=$RABBITMQ_USERNAME --password=$RABBITMQ_PASSWORD --check=list_nodes --filter="$FILTER" --conf=$CONF