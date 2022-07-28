# README

## Oral History

In development... 

## Up and Running

    docker-compose up -d

## TODO automate script it

## JUST ONCE

## Create Database (just once)

    docker exec -i <dockerid>  mysql -uroot -prood  -e "create database cmdi_forms"
    docker exec -i <dockerid>  mysql -uroot -prood cmdi_forms < cmdi_forms.sql
    # dockerid from the mariadb container

## create folders wiht right privileges

    docker exec -i <dockerid> mkdir /var/www/html/ccf/data/records/inprogress/
    docker exec -i <dockerid> chmod 777 /var/www/html/ccf/data/records/inprogress/


## get the Profile running

    docker exec -i <dockerid> python3 ccf/ccf-add-profile.py Interview 'Oral History'
    # dockerid from the php-apache container

## show a list of the records

    http://localhost/ccf/

## login

WATCH IT: login with oral oral

## Permissions (just once)

cd smarty/
chmod 777 templates_c
cd ..
cd data
chmod 777 uploads/ records/ records/inprogress/ 


 ## clean up

    docker exec -i <dockerid>   mysql -uroot -prood  -e "drop  database cmdi_forms"
    docker exec -i <dockerid> rm -fr docker exec -i <dockerid> rm -fr /var/www/html/ccf/data/records/inprogress/
