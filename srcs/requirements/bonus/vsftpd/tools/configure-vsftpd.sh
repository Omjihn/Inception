#!/bin/sh

mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

adduser --disabled-password $FTP_LOGIN
echo "$FTP_LOGIN:$FTP_PASSWORD" | chpasswd

echo "$FTP_LOGIN" >> /etc/vsftpd.userlist

while [ ! -f /var/www/html/wp-config.php ]; do
	sleep 5
done

mkdir -p /var/www/html
chown -R $FTP_LOGIN:$FTP_LOGIN /var/www/html

vsftpd /etc/vsftpd/vsftpd.conf