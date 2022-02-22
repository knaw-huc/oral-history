# Development Clariah-Forms stack

Instead of local versions of everything for development. 
One docker-compose 

Split out the original Dockerfile.
Just a php service and a mysql-service.

Needed the xml and xsl extensions for php 7.4.


https://stackoverflow.com/questions/65554220/trying-to-add-libxslt-to-docker-container

https://stackoverflow.com/questions/59784434/what-is-required-library-needed-for-installing-xmlreader-in-php7-2-fpm-alpine-c

You need  to remove dom, xmlwriter and xmlreader

Maar eens error_reporting volaan gezet.


 Deprecated: The each() function is deprecated. This message will be suppressed on further calls in /var/www/html/ccf/smarty/sysplugins/smarty_internal_compilebase.php on line 75

http://localhost/ccf/index.php?page=profile&id=6

```
Warning: simplexml_load_string(): Entity: line 353: parser error : Input is not proper UTF-8, indicate encoding ! Bytes: 0x91 0x6F 0x63 0x65 in /var/www/html/ccf/classes/CcfParser.class.php on line 12

Warning: simplexml_load_string(): ins any form of unstructured alternative name used for a manuscript, such as an in /var/www/html/ccf/classes/CcfParser.class.php on line 12

Warning: simplexml_load_string(): ^ in /var/www/html/ccf/classes/CcfParser.class.php on line 12

```

