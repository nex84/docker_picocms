FROM php:5.6.35-apache-jessie
MAINTAINER Alexandre Schwartzmann <schwartzmann.a@gmail.com>

LABEL version="1.0"
LABEL os-version="debian:jessie"
LABEL apache-version="2.4"
LABEL php-version="5.6.35"

ADD installer.php /var/www/html/
ADD htmly.conf /etc/apache2/sites-available/

RUN apt-get update && apt-get -y install apt-transport-https wget vim
RUN wget https://github.com/danpros/htmly/archive/v2.7.4.tar.gz ; tar -zxf v2.7.4.tar.gz -C /tmp/
RUN rm -rf /var/www/html; mv /tmp/htmly-2.7.4 /var/www/html ; chown -R www-data: /var/www/html
RUN mv /var/www/html/config/config.ini.example /var/www/html/config/config.ini
RUN mv /var/www/html/config/users/username.ini.example /var/www/html/config/users/username.ini
RUN sed -i "s/site\.url = \"\"/site.url = \"localhost\"/g" /var/www/html/config/config.ini
RUN a2enmod rewrite
RUN a2dissite 000-default
RUN a2ensite htmly

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
