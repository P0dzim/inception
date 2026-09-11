FROM debian:12-slim
RUN apt-get update && apt-get install -y vsftpd && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY conf/vsftpd.conf /etc/vsftpd.conf
COPY tools/entrypoint.sh /tmp/entrypoint.sh
RUN chmod +x /tmp/entrypoint.sh
EXPOSE 21 40000-40005
ENTRYPOINT ["/tmp/entrypoint.sh"]
