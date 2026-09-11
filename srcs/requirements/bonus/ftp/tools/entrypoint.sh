#!/bin/bash

# Verifica se o usuário já existe no sistema para evitar erros caso o container reinicie
if ! id "$FTP_USER" &>/dev/null; then

    # 1. Cria o usuário e aponta a pasta raiz dele para o volume do site
    useradd -d /var/www/html "$FTP_USER"

    # 2. Define a senha utilizando a variável de ambiente
    echo "$FTP_USER:$(cat /run/secrets/ftp_password)" | chpasswd

    # 3. Transfere a posse dos arquivos do WordPress para este novo usuário
    chown -R "$FTP_USER:$FTP_USER" /var/www/html

fi
mkdir -p /var/run/vsftpd/empty
# 4. Inicia o daemon do FTP em primeiro plano (PID 1)
exec /usr/sbin/vsftpd /etc/vsftpd.conf
