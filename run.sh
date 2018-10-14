#!/bin/bash
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
apt update && apt install yarn -y
mkdir -p app/cache my_project/app/logs
touch app/logs/prod.log
touch app/logs/dev.log
chgrp -R www-data .
chmod -R g+w app/cache my_project/app/logs
source /etc/apache2/envvars
tail -F /var/log/apache2/* app/logs/prod.log app/logs/dev.log &
exec apache2 -D FOREGROUND