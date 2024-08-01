#!/bin/bash

B="$BACKUP_NAME-`date +%y%m%d%H%M`"
mkdir -p /opt/local-backup/$B
cd /opt/local-backup/$B
cp -rp /data/records .
cp -rp /data/resources .
mysqldump -h $DB_SERVER -u $DB_USER --password=$DB_PASSWD $DB_NAME metadata_records | grep INSERT > records/records.sql
cp -p /data/htp .
cp -p /data/.htaccess .
tar cvfz $BACKUP_FILE .