#!/bin/bash
apt install nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install yarn -y
mkdir -p app/cache /app/logs
a2enmod php7.1
update-alternatives --set php /usr/bin/php7.1
update-alternatives --set phar /usr/bin/phar7.2
update-alternatives --set phar.phar /usr/bin/phar.phar7.1
update-alternatives --set phpize /usr/bin/phpize7.1
update-alternatives --set php-config /usr/bin/php-config7.1
systemctl restart apache2
touch app/logs/prod.log
touch app/logs/dev.log
chgrp -R www-data .
chmod -R g+w app/cache /app/logs
source /etc/apache2/envvars
tail -F /var/log/apache2/* app/logs/prod.log app/logs/dev.log &
exec apache2 -D FOREGROUND