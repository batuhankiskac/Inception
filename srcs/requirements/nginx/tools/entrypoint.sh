#!/usr/bin/env bash

set -euo pipefail

: "${LOGIN:?}"

SSL_KEY="/etc/ssl/private/nginx-selfsigned.key"
SSL_CERT="/etc/ssl/certs/nginx-selfsigned.crt"

if [ ! -f "${SSL_KEY}" ] || [ ! -f "${SSL_CERT}" ]; then
	echo "[nginx] generating self-signed cert for ${LOGIN}.42.fr ..."
	mkdir -p "$(dirname "${SSL_KEY}")" "$(dirname "${SSL_CERT}")"
	openssl req -x509 -nodes -days 365 \
		-newkey rsa:4096 \
		-keyout "${SSL_KEY}" \
		-out "${SSL_CERT}" \
		-subj "/CN=${LOGIN}.42.fr"
fi

envsubst < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

exec nginx -g 'daemon off;'
