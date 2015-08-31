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
    
    result=getName(id)
    start_container.start(result)
    
    
def getName(id):
    """Gets image name by id"""
    cli = Client(**(kwargs_from_env()))

    docker_inspect='docker inspect -f "{{json .Config.Image }}" '+ id
	
    image_name=json.loads(subprocess.check_output(docker_inspect, shell=True))

    result=image_name.rsplit('/')[1]

    print result        
    return result


if __name__ == '__main__':
    main()
