FROM alpine:3.12

RUN apk update ; \
apk add  --no-cache \
openrc  \
openssl \
php7 \
php7-fpm \
php7-common \
php7-iconv \
php7-json \
php7-opcache \
php7-gd \
php7-curl \
php7-xml \
php7-mysqli \
php7-imap \
php7-cgi \
fcgi \
php7-pdo \
php7-pdo_mysql \
php7-soap \
php7-xmlrpc \
php7-posix \
php7-mcrypt \
php7-zlib \
php7-gettext \
php7-ldap \
php7-ctype \
php7-dom \
php7-mbstring \
php7-json \
php7-session


RUN apk add  --no-cache \
nginx \
&& adduser -D -g 'www' www \
&& mkdir /www \
&& chown -R www:www /var/lib/nginx \
&& chown -R www:www /www ; \
rm /etc/nginx/nginx.conf \
&& openssl req -x509 -nodes -days 365 \
-newkey rsa:2048 -keyout /etc/ssl/private/selfsigned.key \
-out /etc/ssl/certs/selfsigned.crt \
-subj "/C=FR/ST=Lyon/L=Lyon/O=thjacque/OU=42/CN=42.fr"
ADD ./srcs/default /etc/nginx/nginx.conf

RUN apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache \
; mkdir -p /usr/share/webapps/ ;  \
cd /usr/share/webapps   ;\
wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.4-all-languages.tar.gz ;\
tar zxf phpMyAdmin-5.0.4-all-languages.tar.gz ; \
rm phpMyAdmin-5.0.4-all-languages.tar.gz ; \
mv phpMyAdmin-5.0.4-all-languages phpmyadmin ; \
chmod -R 777 /usr/share/webapps/ ; \
ln -s /usr/share/webapps/phpmyadmin/ /var/www/localhost/htdocs/phpmyadmin \
;  rm -rf /usr/share/nginx/html

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

ADD ./srcs/config.inc.php /usr/share/webapps/phpmyadmin/
ADD ./srcs/pma.sh /pma.sh
ADD ./srcs/alive.sh /alive.sh

RUN chmod +x /pma.sh /alive.sh

EXPOSE 5000

STOPSIGNAL SIGTERM

CMD sh /pma.sh