#!/bin/bash/
mkdir -p /run/openrc/
touch /run/openrc/softlevel
sh /alive.sh & 
(telegraf conf &) && php-fpm7 && nginx -g 'pid /tmp/nginx.pid; daemon off;'

