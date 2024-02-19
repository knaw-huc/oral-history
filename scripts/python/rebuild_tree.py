# -*- coding: utf-8 -*-
import argparse
from datetime import datetime
from lxml import etree as ET
import glob
import locale
locale.setlocale(locale.LC_ALL, 'nl_NL') 
import os
import re
import sys
import xmlschema
from pprint import pprint


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
                    #default= "test/")
    ap.add_argument("-t", "--test", action="store_true",
                    help="test run: don't override original files, default=False")
    args = vars(ap.parse_args())
    return args


if __name__ == "__main__":
    stderr(datetime.today().strftime("start: %H:%M:%S"))
    args = arguments()
    inputdir = args['inputdir']
    test_run = args['test']
    stderr(f'test: {test_run}')
    log_homepage = open('no_homepage_log.csv','w')
    log_homepage.write('identifier;location_type;status;file_name\n')
    log_validate_failed = open('validate_failed_log.csv','w')
    log_validate_failed.write('identifier;filename;error\n')
    log_no_summary = open('no_summary_log.csv','w')
    log_no_summary.write('identifier;filename\n')
    teller = 0
    count_changed = 0
    count_location_type = {}
    status = ''
    #
    try:
        xsd = xmlschema.XMLSchema('Vocabulary.xsd',locations=[('http://www.clarin.eu/cmd/1','cmd-envelop.xsd')])
    except:
        stderr('reading xsd failed')
        exit(1)

    '''
    schrijf een XSLT of python script om:
* te checken  of de top locatie een homepage is, zo niet print een warning zodat we ernaar kunnen kijken bij de curatie (evt. de status op review zetten)
* als er een summary is dan die verplaatsen naar de eerste versie, als die er niet is plaats dan een warning zodat we kunnen cureren (evt. versie 0 aanmaken)
    '''

    all_files = glob.glob(inputdir + "**/*.cmdi", recursive = True)     
    stderr(f'input dir contains {len(all_files)} files')
    for f in all_files:
        file_changed = False
        teller += 1
        ns = get_element_namespaces(f)
        tree = ET.parse(f)
        ET.indent(tree, space='    ', level=0)
        root = tree.getroot()
        identifier = root.findall('.//cmd:identifier',ns)[0].text
        status = root.findall('.//cmd:status',ns)[0]
        try:
            location_type = root.findall('.//cmd:Location/cmd:type',ns)[0].text
        except IndexError:
            location_type = 'unknown'
        if not location_type=='homepage':
            log_homepage.write(f'{identifier};{location_type};{status.text};{f}\n')
            status.text = "review"
            file_changed = True
        if location_type in count_location_type:
            count_location_type[location_type] += 1
        else:
            count_location_type[location_type] = 1
        #
        summary = root.find('.//cmd:Summary',ns)
        if summary is None:
            log_no_summary.write(f'{identifier};{f}\n')
            status.text = "review"
        else:
            vocab = root.find('.//cmd:Vocabulary',ns)
            version = root.findall('.//cmd:Version',ns)
            if version is None:
                if vocab is not None:
                    version = ET.SubElement(vocab,'Version',nsmap=ns)
                    v = ET.SubElement(version,'version',nsmap=ns)
                    v.text = '0'
            if version:
                version[0].append(summary)
                status.text = "review"
                file_changed = True
        #
        if file_changed:
            count_changed += 1
            if test_run:
                uitvoer = f.replace('/','_')
                uitvoer = uitvoer.replace('test_','test2/')
                uitvoer = uitvoer.replace('html_','test3/')
                uitvoer = uitvoer.replace('.._.._','')
                ET.indent(tree, space='    ', level=0)
                tree.write(uitvoer, encoding='utf-8')
            else:
                ET.indent(tree, space='    ', level=0)
                tree.write(uitvoer, encoding='utf-8')
            try:
                xsd.validate(uitvoer)
            except Exception as e:
                md = re.search(r'(Reason: [^\n]+)\n',f'{e}')
                if md:
                    log_validate_failed.write(f'{identifier};{f};{md.group(1)}\n')
                else:
                    stderr(f'Exception (failed validate): {e}')
                
    stderr(count_location_type)
    stderr(f'{count_changed} changed records')
    stderr(f'total: {teller}')
    stderr(datetime.today().strftime("einde: %H:%M:%S"))

