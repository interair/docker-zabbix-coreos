#! /usr/bin/env bash

export DOCKER_HOST=tcp://127.0.0.1:2375
docker build -t  wddocker.mapbar.com/docker-zabbix-agent .