# -*- coding: utf-8 -*-
import argparse
from datetime import datetime
import xml.etree.ElementTree as ET
import glob
import locale
locale.setlocale(locale.LC_ALL, 'nl_NL') 
import os
import re
import sys


def get_element_namespaces(filename):
    namespace = []
    for key, value in ET.iterparse(filename, events=['start-ns']):
        if key == 'start-ns':
            namespace.append(value)
    return dict(namespace)


def stderr(text,nl='\n'):
    sys.stderr.write(f"{text}{nl}")

def arguments():
    ap = argparse.ArgumentParser(description="")
    ap.add_argument('-d', '--inputdir',
                    help="inputdir",
                    default= "../../html/ccf/data/records/inprogress/")
    args = vars(ap.parse_args())
    return args


if __name__ == "__main__":
    stderr(datetime.today().strftime("start: %H:%M:%S"))
    args = arguments()
    inputdir = args['inputdir']
    teller = 0
    count_location_type = {}
    status = ''

    all_files = glob.glob(inputdir + "**/*.cmdi", recursive = True)     
    stderr(len(all_files))
    for f in all_files:
        teller += 1
        ns = get_element_namespaces(f)
        tree = ET.parse(f)
        root = tree.getroot()
        try:
            status = root.findall('.//cmd:status',ns)[0].text
        except IndexError:
            status = 'unknown'
        try:
            location_type = root.findall('.//cmd:Location/cmd:type',ns)[0].text
        except IndexError:
            location_type = 'unknown'
        if not location_type=='homepage':
            stderr(f'{location_type}: {f} ({status})')
        if location_type in count_location_type:
            count_location_type[location_type] += 1
        else:
            count_location_type[location_type] = 1

    stderr(count_location_type)
    stderr(f'total: {teller}')
    stderr(datetime.today().strftime("einde: %H:%M:%S"))

