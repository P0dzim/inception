FROM debian:12-slim
RUN apt update && apt-get install -y php-fpm php-mysql wget mariadb-client && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN mkdir -p /run/php
COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
WORKDIR /var/www/html
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
COPY ./tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
ENTRYPOINT ["/tmp/entrypoint.sh"]
