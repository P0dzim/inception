FROM debian:12-slim
RUN apt-get update && apt-get install -y nginx openssl && apt-get clean && rm -rf /var/lib/apt/lists/*
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN mkdir -p etc/nginx/ssl && openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=BR/ST=SP/L=Sao Paulo/O=42/OU=42/CN=vitosant.42.fr/UID=login"
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]

