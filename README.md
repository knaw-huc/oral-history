# README

## Oral History

In development... 

## Up and Running

    docker-compose up -d

## Create Database (just once)

    docker exec -i <dockerid>  mysql -uroot -prood  -e "create database cmdi_forms"
    docker exec -i <dockerid>  mysql -uroot -prood cmdi_forms < cmdi_forms.sql
    # dockerid from the mariadb container



## get the Profile running

    docker exec -i <dockerid> python3 ccf/ccf-add-profile.py Interview 'Oral History'
    # dockerid from the php-apache container

## visit the profiles

    http://localhost/ccf/

## Permissions (just once)

cd smarty/
chmod 777 templates_c
cd ..
cd data
chmod 777 uploads/ records/ records/inprogress/ 


 