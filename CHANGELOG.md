# CHANGELOG


## 28-7-2022

- adapted skos_proxy.php for matching words
- delete record gave a wrong redirect, fixed
- added check on non login
- removed .htaccess file, not necessary for testing

## 9-06-2022

- walkthrough / tested it like a new customer, from installation to running
- rewrote README 
- cleanup superfluous profiles

## 13-04-2022


- removed fake folders, was confusing
- make the tweakfile independent of localhost / baseurl
- new InterviewProfile
- new Tweakfile

## 12-04-2022

- very basic login

## 9-3-2022

- cleanup after record delete
- removed ajax from the delete action
- delete didn't work well

## 4-3-2022

- autocomplete working
- proxy.php adapted, educated guess for the input of autocomplete, worked out well
- added stuff to Tweakfile analog like Meertens Collections, titel => Diplomatieke Titel
- skosmos proxy working with skos test: http://localhost/ccf/proxy.php?q=c
- adapted some endpoint variables in js and php

## 3-3-2022

- new interview (& tweak) file

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