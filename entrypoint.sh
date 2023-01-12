#!/bin/bash

if [ -d /tmp/html ]
then
    cp -r /tmp/html /var/www/
fi

mkdir -p \
    /var/www/html/ccf/data/records/inprogress/ \
    /var/www/html/ccf/data/uploads

chmod uga+rwx \
    /var/www/html/ccf/data/uploads/ \
    /var/www/html/ccf/data/records/ \
    /var/www/html/ccf/data/records/inprogress/ \
    /var/www/html/ccf/smarty/templates_c

if [ ! -f /var/www/html/ccf/data/profiles/${PROFILE}.loaded ]; then
    sleep 10 # give mariadb some time to start up
    python3 /var/www/html/ccf/ccf-add-profile.py ${PROFILE} "${TITLE}"
    touch /var/www/html/ccf/data/profiles/${PROFILE}.loaded
fi

apache2-foreground