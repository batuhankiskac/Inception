#!/usr/bin/env bash
set -euo pipefail

: "${MYSQL_DATABASE:?}"
: "${MYSQL_USER:?}"
: "${MYSQL_PASSWORD:?}"
: "${WP_URL:?}"
: "${WP_TITLE:?}"
: "${WP_ADMIN_USER:?}"
: "${WP_ADMIN_PASSWORD:?}"
: "${WP_ADMIN_EMAIL:?}"
: "${WP_SECOND_USER:?}"
: "${WP_SECOND_PASSWORD:?}"
: "${WP_SECOND_EMAIL:?}"

if [[ "${WP_ADMIN_USER}" =~ (admin|administrator) ]]; then
	echo "[wordpress] WP_ADMIN_USER can not contain 'admin/administrator'" >&2
	exit 1
fi

cd /var/www/html

if [ ! -f wp-config.php ]; then
	echo "[wordpress] downloading core..."
	wp core download --allow-root

	echo "[wordpress] generating wp-config.php..."
	wp config create --allow-root \
		--dbname="${MYSQL_DATABASE}" \
		--dbuser="${MYSQL_USER}" \
		--dbpass="${MYSQL_PASSWORD}" \
		--dbhost="mariadb"

	echo "[wordpress] installing site..."
	wp core install --allow-root \
		--url="${WP_URL}" \
		--title="${WP_TITLE}" \
		--admin_user="${WP_ADMIN_USER}" \
		--admin_password="${WP_ADMIN_PASSWORD}" \
		--admin_email="${WP_ADMIN_EMAIL}"

	echo "[wordpress] creating secondary user..."
	wp user create --allow-root \
		"${WP_SECOND_USER}" "${WP_SECOND_EMAIL}" \
		--role=editor \
		--user_pass="${WP_SECOND_PASSWORD}"
fi

exec php-fpm7.4 -F
