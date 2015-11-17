#! /usr/bin/env python

"""Gets image name by id of existing container and start new same container"""

import click
from docker import Client
from docker.utils import kwargs_from_env
import sys
import os
import json
import subprocess
import docker_name_calculator
import start_container
import requests

@click.command()
@click.argument('id')
def main(id):
    
    req=requests.post("http://opentsp-gateway-eureka:8761/ui/api/containers/"+image_name+"/scale")
    print req



if __name__ == '__main__':
    main()