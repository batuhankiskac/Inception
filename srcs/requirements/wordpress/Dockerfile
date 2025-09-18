FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      php-fpm php-mysql php-cli php-curl php-xml php-mbstring php-zip php-gd \
      curl ca-certificates less unzip tar \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /usr/local/bin/wp \
 && chmod +x /usr/local/bin/wp
