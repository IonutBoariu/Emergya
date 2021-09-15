#!/usr/bin/env bash

cd ..

composer install --prefer-dist

composer require drush/drush

cd web

# Wait until database has been imported before proceeding.
# Scan for the MySQL service defined in the compose file on 3306.
printf "\n- Wait for database import -\n"

until nc -z -v -w1 db 3306
do
   sleep 5
done

printf "\n- Database import successfully completed -\n"

printf "\n- Drush commands processing, please standby -\n";

drush status

printf "\n- Clearing all drupal caches -\n\n";
drush cache-rebuild

printf "\n- Apply any required database updates -\n\n";
drush updb -y

cd ..
chown www-data:www-data -R config
chown www-data:www-data -R web
cd web

printf "\n- Import Configurations -\n\n";
drush config-import -y --partial

printf "\n- Drush commands have finished processing -\n";

