FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      php-fpm php-mysql php-cli php-curl php-xml php-mbstring php-zip php-gd \
      curl ca-certificates less unzip tar \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
 && chmod +x /usr/local/bin/wp

RUN sed -ri 's#^;?daemonize\s*=.*#daemonize = no#' /etc/php/7.4/fpm/php-fpm.conf \
 && sed -ri 's#^listen\s*=.*#listen = 0.0.0.0:9000#' /etc/php/7.4/fpm/pool.d/www.conf

WORKDIR /var/www/html

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 9000
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
