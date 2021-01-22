FROM alpine:3.12

EXPOSE 8086

RUN apk -U upgrade \
; apk add --no-cache \
openrc \
; apk add influxdb \
; apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY srcs/start.sh /start.sh
COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf

RUN chmod 777 /start.sh
CMD sh start.sh
