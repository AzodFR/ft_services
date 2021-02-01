FROM alpine:3.12

COPY ./srcs/mysql_config.sh /mysql_config.sh

RUN chmod +x /mysql_config.sh

RUN apk -U upgrade && \
apk add --no-cache \
openrc mysql mysql-client && \
rm -f /var/cache/apk/* \
; apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache 

COPY ./srcs/mariadb-server.cnf /etc/my.cnf.d/
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

EXPOSE 3306

CMD sh mysql_config.sh