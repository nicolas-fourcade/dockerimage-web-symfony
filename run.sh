#!/bin/bash
mkdir -p my_project/app/cache my_project/app/logs
touch my_project/app/logs/prod.log
touch my_project/app/logs/dev.log
chgrp -R www-data .
chmod -R g+w my_project/app/cache my_project/app/logs
source /etc/apache2/envvars
tail -F /var/log/apache2/* my_project/app/logs/prod.log my_project/app/logs/dev.log &
exec apache2 -D FOREGROUND
