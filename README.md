# README

## Huc CMDI App

In development... 

## Up and Running

    docker-compose up -d

## Important locations and configuration, different for each app

    docker-compose.yml 
    # adapt TITLE and PROFILE, the name of the profile must be the name of the XML profile file without the xml extension

    html/ccf/data/profiles/Profilename.xml
    html/ccf/data/profiles/ProfilenameTweak.xml

    html/ccf/config/listview.json
    # extracts names and data from the profile for the listview in this app


## JUST ONCE

TODO: script this process

### Create Database
    docker ps
    # obtain container-id's, one for mariadb, one for php-apache

    # if not exists, probably not necessary, database is created first time docker-compose is run
    docker exec -i <docker-mariadb-id>  mysql -uroot -prood  -e "create database cmdi_forms"
    
    docker exec -i <docker-mariadb-id>  mysql -uroot -prood cmdi_forms < cmdi_forms.sql
    # dockerid from the mariadb container
    
### create folders wiht right privileges
    # if not exists probably also not neccesary
    docker exec -i <docker-php-id> mkdir /var/www/html/ccf/data/records/inprogress/

    docker exec -i <docker-php-id> chmod 777 /var/www/html/ccf/data/records/inprogress/


### Permissions PHP container

login php container

    cd smarty/
    chmod 777 templates_c
    cd ..
    cd data
    chmod 777 uploads/ records/ records/inprogress/ 


## IMPORTANT get the Profile running

    docker exec -i <docker-php-id> python3 ccf/ccf-add-profile.py <Profilename> <Title>
    # THE FIRST ARGUMENT AFTER ccf-add-profile.py is the name of the Profile 
    # This python script expects a profile in html/ccf/data/profiles/ withe the name <Profilename>.xml
    # This python script can expect a Tweak file in html/ccf/data/tweaks with the name <Profilename>Tweak.xml

    # dockerid from the php-apache container

## show a list of the records

    http://localhost/ccf/


 ## clean up

    docker exec -i <docker-mariadb-id>   mysql -uroot -prood  -e "drop  database cmdi_forms"
    docker exec -i <docker-php-id> rm -fr /var/www/html/ccf/data/records/inprogress/

