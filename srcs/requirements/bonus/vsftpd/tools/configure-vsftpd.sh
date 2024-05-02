#!/bin/sh

mv /tmp/vsftpd.conf /etc/vsftpd/vsftpd.conf

chown -R $FTP_LOGIN:$FTP_LOGIN /var/www/html

adduser --disabled-password $FTP_LOGIN
echo "$FTP_LOGIN:$FTP_PASSWORD" | chpasswd

echo "$FTP_LOGIN" >> /etc/vsftpd.userlist

while [ ! -f /var/www/html/wordpress/wp-config.php ]; do
	echo "Waiting for wordpress configuration..."
	sleep 5
done

vsftpd /etc/vsftpd/vsftpd.conf