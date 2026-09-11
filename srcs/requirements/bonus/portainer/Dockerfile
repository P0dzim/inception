FROM debian:12-slim
RUN apt-get update && apt-get install -y wget tar ca-certificates && apt-get clean && rm -rf /var/lib/apt/lists/*
WORKDIR /app
RUN wget https://github.com/portainer/portainer/releases/download/2.19.4/portainer-2.19.4-linux-amd64.tar.gz && tar -xzvf portainer-2.19.4-linux-amd64.tar.gz && rm portainer-2.19.4-linux-amd64.tar.gz
EXPOSE 9000
CMD ["/app/portainer/portainer"]
