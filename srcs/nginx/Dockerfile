FROM alpine:latest


EXPOSE 22 80 443

RUN apk update --no-cache
RUN apk upgrade --no-cache

RUN apk add nginx
RUN adduser -D -g 'www' www
RUN echo "www:www" | chpasswd

RUN mkdir -p /run/nginx /www /etc/nginx/ssl

RUN chown -R www:www /var/lib/nginx && chown -R www:www /www

COPY srcs/start.sh /
COPY srcs/index.html /www/

COPY srcs/nginx.conf /etc/nginx/nginx.conf
RUN chmod +x start.sh
RUN nginx

ENTRYPOINT ["/bin/sh", "/start.sh"]