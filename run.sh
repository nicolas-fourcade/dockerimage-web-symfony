#!/bin/bash
apt install nodejs
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
apt-get update && apt-get install yarn -y
mkdir -p app/cache /app/logs
touch app/logs/prod.log
touch app/logs/dev.log
chgrp -R www-data .
chmod -R g+w app/cache /app/logs
source /etc/apache2/envvars
tail -F /var/log/apache2/* app/logs/prod.log app/logs/dev.log &
exec apache2 -D FOREGROUND