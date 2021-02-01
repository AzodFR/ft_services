FROM alpine:3.12

RUN apk -U upgrade && \
apk add --no-cache \
wget \
php7 \php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-phar curl nginx openssl openrc \
; adduser -D -g 'www' www \
; mkdir /www \
; chown -R www:www /var/lib/nginx \
; chown -R www:www /www \
; rm /etc/nginx/nginx.conf \
&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key -out /etc/ssl/certs/selfsigned.crt -subj "/C=FR/ST=Lyon/L=Lyon/O=thjacque/OU=42/CN=42.fr" \
; mkdir -p /usr/share/webapps/ \
; cd /usr/share/webapps/ \
; wget http://wordpress.org/latest.tar.gz \
; tar -xzvf latest.tar.gz && rm latest.tar.gz \
; apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache \
; curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
; chmod +x wp-cli.phar \
; mv wp-cli.phar /usr/local/bin/wp


COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./srcs/default /etc/nginx/conf.d/default.conf
COPY ./srcs/default /etc/nginx/nginx.conf
COPY ./srcs/wp-config.php /usr/share/webapps/wordpress/wp-config.php
COPY ./srcs/wp.sh    ./wp.sh
COPY ./srcs/alive.sh /alive.sh
RUN chmod +x ./wp.sh /alive.sh

EXPOSE 5050

CMD sh wp.sh