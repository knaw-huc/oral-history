# CHANGELOG

## 25-2-2022

- adapted readme, still in development
- env in python initiation script
- environmental variables readout on formpage, title
- test with new fieldnames, success
- bugfix profile_id in listview
- cleanup listview
- listview configurable with .json file in config, two elements: 
    - display value and 
    - the extraction value from the cmdi record
- extraction of list elements a bit softer, regexp

## 24-2-2022

- parsed xml through json to obtain useful information for the list view
- list view now minimal viable

## 22-2-2022

- started to make the application more standalone and configurable for a single .xml file
- environment variables
- added several functions in the router (functions.php), in the dbclass (getProfiledata) 
- added seperate template for the list_records
- rerouted the default to list_records in functions.php
- pushed the code to github
- more investigation in current app

## 18-2-2022

- converted the monolith to two separate containers php-apache and mysql
- investigated some time in understanding the flow of the current application