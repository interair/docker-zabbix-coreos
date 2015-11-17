#! /usr/bin/env python

"""Gets image name by id of existing container and start new same container"""

import click
from docker import Client
from docker.utils import kwargs_from_env
import sys
import os
import json
import subprocess
import requests

@click.command()
@click.argument('id')
def main(id):
    try:
        req=requests.post("http://opentsp-gateway-eureka:8761/ui/api/containers/"+id+"/scale")
        print req
    except Exception, e:
        print "can't schedule container {0} ".format(e)

if __name__ == '__main__':
    main()