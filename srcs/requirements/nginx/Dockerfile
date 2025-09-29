FROM debian:bullseye-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends nginx openssl gettext-base ca-certificates \
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/conf.d
COPY conf/default.conf.template /etc/nginx/conf.d/default.conf.template

COPY tools/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

EXPOSE 443
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
