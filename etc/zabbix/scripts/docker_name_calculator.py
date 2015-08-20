#! /usr/bin/env python

"""docker_name_calculator.py: Generates a unique name for a specified image"""

__auther__ = "Carter Harwood"
__copyright__ = ""
__credits__ = ["Carter Harwood", "Vitaly Pronto"]
__license__ = ""
__version__ = "0.0.1"
__maintainer__ = "Carter Harwood"
__email__ = "carter@codeabovelab.com"
__status__ = "Development"

import click
from docker import Client
from docker.utils import kwargs_from_env


@click.command()
@click.argument('image')
def main(image):
    """Generates a unique name for a specified image"""
    calculate(image)
    
def calculate(image):
    cli = Client(**(kwargs_from_env()))

    image_name = image.split(':',1)[0].rsplit('.',1)[-1]

    containers = cli.containers(all=True)

    image_of_type_list = []

    for i in containers:
        n = str(i['Names'][0].split('/')[-1])

        if (image_name == n.rsplit('-',1)[0] or image_name == n):
            image_of_type_list.append(n)

    ## If first instance of type
    if not image_of_type_list:
        print image_name
        return image_name

    last = sorted(image_of_type_list)[-1]

    num = last.rsplit('-',1)[-1]
    if num.isdigit():
        image_name = image_name + '-' + `int(last.rsplit('-',1)[-1])+1`
        print image_name 
        return image_name
    else:
        image_name = image_name + '-1'
        print image_name 
        return image_name


if __name__ == '__main__':
    main()