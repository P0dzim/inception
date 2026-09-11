#!/bin/bash
set -e

DB_PASSWORD="$(cat /run/secrets/db_password)"
WP_ADMIN_PASSWORD="$(cat /run/secrets/wp_admin_password)"
WP_USER_PASSWORD="$(cat /run/secrets/wp_user_password)"

# Aguarda o MariaDB aceitar conexões usando PHP
until mysqladmin ping -h"mariadb" -u"${MYSQL_USER}" -p"${DB_PASSWORD}" --silent; do
    echo "Aguardando MariaDB..."
    sleep 1
done

echo "MariaDB disponível."
# Baixa o WordPress somente se ainda não estiver presente
if [ ! -f /var/www/html/wp-load.php ]; then
    wp core download \
        --allow-root \
        --path=/var/www/html
fi

# Cria o wp-config somente se ainda não existir
if [ ! -f /var/www/html/wp-config.php ]; then
    wp config create \
        --allow-root \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="mariadb:3306" \
        --path=/var/www/html
fi

# Instala o WordPress somente se ainda não estiver instalado
if ! wp core is-installed --allow-root --path=/var/www/html; then

    wp core install \
        --allow-root \
        --url="${DOMAIN_NAME}" \
        --title="Inception 42" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=/var/www/html

    wp user create \
        --allow-root \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --path=/var/www/html
fi

wp config set WP_REDIS_HOST "redis" --allow-root --path=/var/www/html

wp plugin install redis-cache --activate --allow-root --path=/var/www/html

wp redis enable --allow-root --path=/var/www/html

exec /usr/sbin/php-fpm8.2 -F

