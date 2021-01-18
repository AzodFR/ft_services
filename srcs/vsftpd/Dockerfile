FROM alpine:latest

RUN apk update --no-cache
RUN apk upgrade --no-cache

RUN apk add vsftpd --no-cache
RUN apk add openssl --no-cache

RUN apk add openrc --no-cache

RUN openrc boot

RUN adduser -D -g 'admin' admin
RUN echo "admin:admin" | chpasswd

RUN mkdir -p /etc/vsftpd/ssl

COPY ./srcs/vsftpd.conf /etc/vsftpd/vsftpd.conf

RUN openssl req -new -x509 -days 365 -nodes -out /etc/ssl/private/vsftpd.cert.pem -keyout /etc/ssl/private/vsftpd.key.pem \
    -subj "/C=FR/ST=France/L=Lyon/O=42/OU=thjacque/CN=localhost/emailAddress=thjacque@student.42lyon.fr"

COPY ./srcs/start.sh /start.sh
RUN chmod +x /start.sh
