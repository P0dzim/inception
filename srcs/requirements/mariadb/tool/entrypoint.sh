#!/bin/sh

chown -R mysql:mysql /var/lib/mysql

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql > /dev/null

    # Leitura segura das senhas via Docker Secrets
    DB_PASSWORD=$(cat /run/secrets/db_password)
    ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
    MANAGER_PASSWORD=$(cat /run/secrets/db_manager_password)

    cat << EOF > /tmp/init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;

-- Usuário comum
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

-- Usuário Administrador (O nome virá da variável MYSQL_MANAGER no .env)
CREATE USER IF NOT EXISTS '${MYSQL_MANAGER}'@'%' IDENTIFIED BY '${MANAGER_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_MANAGER}'@'%' WITH GRANT OPTION;

-- Configuração do Root
ALTER USER 'root'@'localhost' IDENTIFIED BY '${ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

    /usr/sbin/mariadbd --user=mysql --bootstrap < /tmp/init.sql
    rm /tmp/init.sql
fi

exec /usr/sbin/mariadbd --user=mysql --console
