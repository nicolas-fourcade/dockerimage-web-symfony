FROM ubuntu:16.04
ADD . /app

ADD ondrej-ubuntu-php-xenial.list /etc/apt/sources.list.d/
RUN apt-get update -y --fix-missing
# Install php7.1
RUN apt-get install -y --allow-unauthenticated php7.1 apache2 libapache2-mod-php7.1 php7.1-sqlite3 php7.1-mbstring php7.1-xdebug php7.1-intl curl php7.1-curl php7.1-xml composer zip unzip php7.1-zip
# Install nodejs
RUN apt install nodejs -y --allow-unauthenticated
# Configure Apache
RUN rm -rf /var/www/* \
    && a2enmod rewrite \
    && echo "ServerName localhost" >> /etc/apache2/apache2.conf
ADD vhost.conf /etc/apache2/sites-available/000-default.conf
# Install Symfony
RUN mkdir -p /usr/local/bin
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony
RUN chmod a+x /usr/local/bin/symfony
# Add main start script for when image launches
ADD run.sh /run.sh
RUN chmod 0755 /run.sh
WORKDIR /app
EXPOSE 80
CMD ["/run.sh"]
