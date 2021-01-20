FROM alpine:3.12

RUN apk -U upgrade \
&& apk add --no-cache \
openrc \
grafana --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache \
; apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/community/ --allow-untrusted --no-cache

COPY srcs/telegraf.conf /etc/telegraf/telegraf.conf
COPY srcs/grafana.db /usr/share/grafana/data/grafana.db

EXPOSE 3000

CMD (telegraf conf &) && grafana-server --homepath "/usr/share/grafana" start