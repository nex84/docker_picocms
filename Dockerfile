FROM php:5.6.35-apache-jessie
MAINTAINER Alexandre Schwartzmann <schwartzmann.a@gmail.com>

LABEL version="1.0"
LABEL os-version="debian:jessie"
LABEL apache-version="2.4"
LABEL php-version="5.6.35"

ADD installer.php /var/www/html/
ADD htmly.conf /etc/apache2/sites-available/

RUN apt-get update && apt-get -y install apt-transport-https wget vim
RUN mkdir /tmp/pico
RUN wget https://github.com/picocms/Pico/releases/download/v1.0.6/pico-release-v1.0.6.tar.gz ; tar -zxf pico-release-v1.0.6.tar.gz -C /tmp/pico/
RUN rm -rf /var/www/html; mv /tmp/pico/ /var/www/html ; chown -R www-data: /var/www/html
RUN ls -ltrah  /var/www/html
RUN a2enmod rewrite
RUN a2dissite 000-default
RUN a2ensite htmly

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
