# README

## Huc CMDI App

In development... 

## Up and Running

    docker-compose build
    docker-compose up -d

## Important locations and configuration, different for each app

    docker-compose.yml 
    # adapt TITLE and PROFILE, the name of the profile must be the name of the XML profile file without the xml extension

    html/ccf/data/profiles/Profilename.xml
    html/ccf/data/profiles/ProfilenameTweak.xml

    html/ccf/config/listview.json
    # extracts names and data from the profile for the listview in this app

## show a list of the records

    http://localhost/ccf/


 ## clean up

    docker exec -i <docker-mariadb-id>   mysql -uroot -prood  -e "drop  database cmdi_forms"
    docker exec -i <docker-php-id> rm -fr /var/www/html/ccf/data/records/inprogress/