#!/usr/bin/env python3

from datetime import date
import os.path
import os
import sys
import getpass
import mysql.connector
from mputility import testDatabase

# db CONSTANTS
DB_USER = os.getenv('DB_USER')
DB_PASSWD = os.getenv('DB_PASSWD')
DB_SERVER = os.getenv('DB_SERVER')
DB_NAME = os.getenv('DB_NAME')

# print(DB_PASSWD)
# exit(1)

# USER = 'root'
# PASSWORD = 'rood'
# HOST = 'mysql'
# DATABASE = 'cmdi_forms'

# PATHS
DATA='/var/www/html/ccf/data/'
TMP='/tmp'

# SYSTEM VARIABLES
TODAY = date.today() #default yyyy-mm-dd
# print(TODAY)
# exit(1)
WHOAMI = getpass.getuser()

# HANDLE CMD line ARGUMENTS
if len(sys.argv) - 1 == 0:
    print("RR: missing profile file name (without extension)")
    exit(1)


# PROFILE HANDLING
PROFILE = sys.argv[1] # first argument commandline
PROFILEPATH = DATA + '/profiles/' + PROFILE + '.xml'

DESCR = PROFILE
if len(sys.argv) > 1:
    DESCR = sys.argv[2]

if not os.path.isfile(PROFILEPATH):
    print("ERR: " + PROFILEPATH + "can't be found!")
    exit(1)

f = open(PROFILEPATH)
profilexml = f.read()
f.close()
# print(profilexml)

TWEAK = ''
TWEAKPATH = DATA + '/tweaks/' + PROFILE + '.xml'
if os.path.isfile(TWEAKPATH):
    f = open(TWEAKPATH)
    tweakxml = f.read()
    f.close()
else:
    tweakxml = ''           

#  testDatabase(USER, PASSWORD, HOST, DATABASE)

sql = ( "INSERT INTO profiles (name, description, content, owner, created, language,tweak) "
        "VALUES (%s, %s, %s, %s, %s, %s, %s) "
)

data = (PROFILE, DESCR, profilexml, WHOAMI, TODAY, 'en', tweakxml)
cnx = mysql.connector.connect(user=DB_USER, password=DB_PASSWD,
                                host=DB_SERVER,
                                database=DB_NAME)
cursor = cnx.cursor()   
cursor.execute(sql, data)

# print(sql, data)

# print("The script has the name %s" % (sys.argv[0]))

