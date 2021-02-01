#!/bin/bash

mysql_install_db --user=mysql --datadir=/var/lib/mysql
mkdir /run/openrc
touch /run/openrc/softlevel
openrc
rc-service mariadb start


echo "CREATE DATABASE wordpress;" | mysql -u root
echo "CREATE USER 'root'@'%' IDENTIFIED BY 'root';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'%';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

rc-service mariadb restart
pkill mysqld

(telegraf conf &) && /usr/bin/mysqld --user=root --datadir=/var/lib/mysql
