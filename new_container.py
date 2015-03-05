#!/usr/bin/env python

import argparse
import re
import os
import re

from docker import Client
from docker.utils import kwargs_from_env

def display_status(args):
    containers = c.containers(all=True)
    runContainers = [0]
    for i in containers:
        if(args.image in i['Names'][0]):
            print(i['Names'][0])
            m = re.search("_(\d+)", i['Names'][0])
            if m:
                print m.groups()[0]
                runContainers.append(int(m.groups()[0]))

    runContainers.sort()
    nextContainer = runContainers[-1]+1
    print "{0}_{1}".format(args.image, nextContainer)


parser = argparse.ArgumentParser()

parser.add_argument("image", help="Container name")
parser.set_defaults(func=display_status)

c = Client(**(kwargs_from_env()))

args = parser.parse_args()
args.func(args)
