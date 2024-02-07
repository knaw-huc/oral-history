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
    count_status = {}

    ns = {'cmd':'http://www.clarin.eu/cmd/1'} 
    all_files = glob.glob(inputdir + "**/*.cmdi", recursive = True)     
    stderr(len(all_files))
    for f in all_files:
        if teller>1000:
            break
        teller += 1
        ns = get_element_namespaces(f)
        tree = ET.parse(f)
        root = tree.getroot()
        try:
            res = root.findall('.//cmd:status',ns)[0].text
        except IndexError:
            stderr(f'no status: {f}')
            res = 'unknown'
        if res in count_status:
            count_status[res] += 1
        else:
            count_status[res] = 1

    stderr(count_status)
    stderr(f'total: {teller}')
    stderr(datetime.today().strftime("einde: %H:%M:%S"))

