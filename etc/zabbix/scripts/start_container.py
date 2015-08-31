#! /usr/bin/env python


import click
import sys
import os
import json
import requests
import subprocess
import docker_name_calculator

@click.command()
@click.argument('image_name')
def main(image_name):
    start(image_name)
    
def start(image_name):
    registry="wddocker.mapbar.com"
    try:
        LOG_DIR=os.environ['LOG_DIR']
    except:
        LOG_DIR="/mapbar/data/logs"

    full_name=registry+"/"+image_name

    pull_process=subprocess.call("docker pull "+full_name, shell=True, stdout=subprocess.PIPE)

    docker_inspect='docker inspect -f "{{json .Config.Labels }}" '+full_name

    labels=json.loads(subprocess.check_output(docker_inspect, shell=True))
    
    start=labels["start-string"]
    
    try:
        req=requests.get("http://swarm:8761/info/nodesNameForApp?imageName="+image_name)

        nodes=""
        for index, elem in enumerate(req.json()):
            if (index > 0): 
                nodes+ "|"
            nodes += elem 

        constraint="%opts -e constraint:node!=/*" + nodes + "*/"
        print constraint
        start=start.replace("%opts", constraint, 1)
    except Exception as e:
        print "can't calulate constraints {0} ".format(e)
    

    result=start.replace("%opts","'" + labels["opts"] + "'",1).replace("%memory", labels["memory"],1).replace("%repository", registry,1).replace("%LOG_DIR", LOG_DIR,1)
    if "%name" in labels["start-string"]:
            result=result.replace("%name",docker_name_calculator.calculate(full_name))

    print result
    subprocess.call(result, shell=True, stdout=subprocess.PIPE)
	
if __name__ == '__main__':
    main()
