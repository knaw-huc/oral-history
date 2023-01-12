FROM php:7.4-apache
COPY php-apache/config/php.ini  /usr/local/etc/php/php.ini
RUN apt-get update && apt-get install -y libc-client-dev libfreetype6-dev libmcrypt-dev libpng-dev libjpeg-dev libldap2-dev zlib1g-dev libkrb5-dev libtidy-dev libzip-dev libsodium-dev libpq-dev libxml2-dev libxslt1-dev  && rm -rf /var/lib/apt/lists/* \
	&& docker-php-ext-configure gd --with-freetype --with-jpeg \
	&& docker-php-ext-install gd mysqli pdo pdo_mysql pdo_pgsql opcache zip iconv tidy xml xsl \
    && docker-php-ext-configure ldap --with-libdir=lib/$(gcc -dumpmachine)/ \
    && docker-php-ext-install ldap \
    && docker-php-ext-configure imap --with-imap-ssl --with-kerberos \
    && docker-php-ext-install imap \
    && docker-php-ext-install sodium \
    && pecl install mcrypt-1.0.3 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-install exif

RUN apt-get update && apt-get install -y curl wget unzip vim mariadb-client python3 python3-pip
RUN pip3 install mysql-connector

COPY ./html /var/www/html
WORKDIR /var/www/html

COPY adminer/* /var/www/html/

COPY profile/*.xml /var/www/html/ccf/data/profiles/
RUN mv /var/www/html/ccf/data/profiles/*Tweak.xml /var/www/html/ccf/data/tweaks/
COPY profile/*.json /var/www/html/ccf/config/

# HuC generic editor
RUN mkdir /tmp/editor &&\
    cd /tmp/editor &&\
    wget https://github.com/knaw-huc/huc-generic-editor/archive/refs/tags/test-ci.zip &&\
    unzip test-ci.zip &&\
    rm test-ci.zip &&\
    cp -r huc-generic-editor-test-ci/js /var/www/html/ccf/ &&\
    cp -r huc-generic-editor-test-ci/css /var/www/html/ccf/
    #&&\
    #cd /tmp &&\
    #rm -rf editor

# HuC generic editor
RUN mkdir /tmp/parser &&\
    cd /tmp/parser &&\
    wget https://github.com/knaw-huc/clariah-cmdi-parser/archive/refs/tags/v1.0-rc1.zip &&\
    unzip v1.0-rc1.zip &&\
    rm v1.0-rc1.zip &&\
    cp -r clariah-cmdi-parser-1.0-rc1/classes /var/www/html/ccf/ &&\
    cp -r clariah-cmdi-parser-1.0-rc1/tweaker /var/www/html/ccf/
    #&&\
    #cd /tmp &&\
    #rm -rf editor



ENV DB_SERVER mysql
ENV DB_USER root
ENV DB_PASSWD ${DB_PASSWD:-rood}
ENV DB_NAME cmdi_forms
ENV BASE_URL "http://localhost/ccf/"
RUN htpasswd -b -c /var/www/htp test test

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf && \
    a2enmod rewrite && \
    a2enmod headers && \
    service apache2 restart

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]