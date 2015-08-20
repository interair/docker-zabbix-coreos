#! /usr/bin/env python


import click
import sys
import os
import json
import subprocess
import docker_name_calculator

@click.command()
@click.argument('image_name')
def main(image_name):
	registry="wddocker.mapbar.com"
	try:
            LOG_DIR=os.environ['LOG_DIR']
        except:
            LOG_DIR="/mapbar/data/logs"

	full_name=registry+"/"+image_name
	
	pull_process=subprocess.call("docker pull "+full_name, shell=True, stdout=subprocess.PIPE)

	Docker_inspect='docker inspect -f "{{json .Config.Labels }}" '+full_name
	
	proc = subprocess.check_output(Docker_inspect, shell=True)
	
	obj=json.loads(proc)
	
	result=obj["start-string"].replace("%opts","'" + obj["opts"] + "'",1).replace("%memory", obj["memory"],1).replace("%repository", registry,1).replace("%LOG_DIR", LOG_DIR,1)
	if "%name" in obj["start-string"]:
		result=result.replace("%name",docker_name_calculator.calculate(full_name))

	print result
	subprocess.call(result, shell=True, stdout=subprocess.PIPE)
	
if __name__ == '__main__':
    main()