#!/bin/sh
wp core install --url=https://GLOB_IP:5050 --title=BABINKS --admin_user=azod --admin_password=admin --admin_email=rdm@email.com --path='/usr/share/webapps/wordpress/' --skip-email
while [ $? -ne 0 ] ; do
    wp core install --url=https://GLOB_IP:5050 --title=BABINKS --admin_user=azod --admin_password=admin --admin_email=rdm@email.com --path='/usr/share/webapps/wordpress/' --skip-email
done
wp core install --url=https://GLOB_IP:5050 --title=BABINKS --admin_user=azod --admin_password=admin --admin_email=rdm@email.com --path='/usr/share/webapps/wordpress/' --skip-email
wp user create pierre pierre@feuille.ciseau --first_name=Pierre --last_name=Feuille --user_pass=feuille --role=subscriber --path='/usr/share/webapps/wordpress/'
wp user create paul paul@lemploi.fr --first_name=Paul --last_name=Lemploi --user_pass=chomdu --role=subscriber --path='/usr/share/webapps/wordpress/'
wp user create jacque jacque@lin.th --first_name=Jacque --last_name=Ouille --user_pass=acab --role=subscriber --path='/usr/share/webapps/wordpress/'
(telegraf conf &) && php-fpm7  && (sh alive.sh &) && nginx -g 'pid /tmp/nginx.pid; daemon off;'
