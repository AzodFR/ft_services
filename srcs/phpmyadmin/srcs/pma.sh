#!/bin/bash/
mkdir -p /run/openrc/
touch /run/openrc/softlevel

(telegraf conf &) && php-fpm7 && (sh /alive.sh &) && nginx -g 'pid /tmp/nginx.pid; daemon off;'

