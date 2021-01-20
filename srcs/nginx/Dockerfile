FROM alpine:3.12

RUN apk -U upgrade \
&& apk add --no-cache \
wget \
nginx \
openssl \
openssh \
; apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache \
&& adduser -D -g 'www' www \
&& mkdir /www \
&& chown -R www:www /var/lib/nginx \
&& chown -R www:www /www \
&& ssh-keygen -A \
&& openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=FR/ST=Lyon/L=Lyon/O=tjacque/OU=42/CN=42lyon.fr"

RUN rm /etc/nginx/nginx.conf
COPY ./srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./srcs/start.sh /start.sh
RUN chmod 777 /start.sh

EXPOSE 80 443 22

STOPSIGNAL SIGTERM

ENTRYPOINT ["/bin/sh", "/start.sh"]
