FROM debian:12-slim
RUN apt-get update && apt-get install -y mariadb-server && mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld && rm -rf /var/lib/mysql/* && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY ./tool/entrypoint.sh /tmp/entrypoint.sh
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN chmod +x /tmp/entrypoint.sh
EXPOSE 3306
ENTRYPOINT ["/tmp/entrypoint.sh"]
