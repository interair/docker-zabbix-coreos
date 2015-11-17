#!/usr/bin/python
# -*- coding: utf-8 -*-

import click
import sys
import os
import json
import requests
import subprocess



@click.command()
@click.argument('image_name')
def main(image_name):
    start(image_name)


def start(image_name):

    try:
        words = image_name.split(':')
        if len(words) == 2:
            payload = {'image': words[0], 'tag': words[1]}
        else:
            payload = {'image': image_name}
        json_dump = json.dumps(payload)
        print json_dump
        req = requests.post('http://opentsp-gateway-eureka:8761/ui/apicontainers/create', data=json_dump)
        print req
    except Exception, e:

        print "can't schedule container {0} ".format(e)


if __name__ == '__main__':
    main()