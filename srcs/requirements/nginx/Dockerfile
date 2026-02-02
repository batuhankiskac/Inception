FROM debian:bullseye

RUN apt-get update && apt-get install nginx openssl -y

RUN mkdir -p /etc/nginx/ssl

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

COPY tools/entrypoint.sh /var/www/entrypoint.sh

RUN chmod +x /var/www/entrypoint.sh

EXPOSE 433

ENTRYPOINT [ "/var/www/entrypoint.sh" ]
