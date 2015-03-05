#!/usr/bin/env python

import argparse
import os
import re

from docker import Client
from docker.utils import kwargs_from_env

def create_container(args):
    containers = cli.containers(all=True)
    runContainers = [0]
    for i in containers:
        if(args.name in i['Names'][0]):
            print(i['Names'][0])
            m = re.search("_(\d+)", i['Names'][0])
            if m:
                print m.groups()[0]
                runContainers.append(int(m.groups()[0]))

    runContainers.sort()
    nextContainer = runContainers[-1]+1
    resultName = "{0}_{1}".format(args.name, nextContainer)
    print resultName
    os.system("docker pull {0}".format(args.image)) #remove it! just test
    os.system("docker run -d --name {0} --link opentsp_redis:opentsp_redis --link rabbitmq:rabbitmq --link opentsp-configuration:cloudConfig --link mysql:mysql {1}".format(resultName, args.image)) #remove it! just test


parser = argparse.ArgumentParser()

parser.add_argument("image", help="Container image")
parser.add_argument("name", help="Default name")
parser.set_defaults(func=create_container)

cli = Client(**(kwargs_from_env()))

args = parser.parse_args()
args.func(args)
