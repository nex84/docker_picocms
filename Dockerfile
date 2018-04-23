FROM php:5.6.35-apache-jessie
MAINTAINER Alexandre Schwartzmann <schwartzmann.a@gmail.com>

LABEL version="1.0"
LABEL os-version="debian:jessie"
LABEL apache-version="2.4"
LABEL php-version="5.6.35"

ADD installer.php /var/www/html/
ADD htmly.conf /etc/apache2/sites-available/

RUN wget https://github.com/danpros/htmly/archive/v2.7.4.tar.gz ; tar -zxf v2.7.4.tar.gz -C /var/www/html/
RUN a2enmod rewrite
RUN a2dissite 000-default
RUN a2ensite htmly

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
