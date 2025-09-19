#!/usr/bin/env bash

set -euo pipefail

: "${MYSQL_DATABASE:?}"
: "${MYSQL_USER:?}"
: "${MYSQL_PASSWORD:?}"
: "${MYSQL_ROOT_PASSWORD:?}"

chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
	echo "[mariadb] initializing data directory..."
	mariadb-install-db --user=mysql --data-dir=/var/lib/mysql > /dev/null

	echo "[mariadb] applying bootstrap SQL..."
	tmp_sql="$(mktemp)"

	cat > "$tmp_sql" << SQL
	FLUSH PRIVILEGES;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
	CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
	CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
	GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
	FLUSH PRIVILEGES;
	SQL

	mysqld --user=mysql --data-dir=/var/lib/mysql --bootstrap < "$tmp_sql"
	rm -f "$tmp_sql"
fi

exec mysqld --user=mysql --datadir=/var/lib/mysql --bind-address=0.0.0.0
