#!bin/bash

while ! mariadb -h"mariadb" -u$SQL_USER -p$SQL_PASSWORD $SQL_DATABASE &>/dev/null; do
	echo "Waiting for MariaDB configuration..."
	sleep 2

done

if [ ! -e /var/www/html/wordpress/wp-config.php ]; then

	wp cli update		--yes --allow-root

	wp core download	--allow-root

	wp config create	--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb \
						--path="/var/www/html/wordpress" \
						--allow-root

	wp core install		--url=${DOMAIN_NAME} \
						--title=${SITE_TITLE} \
						--admin_user=${ADMIN_USER} \
						--admin_password=${ADMIN_PASSWORD} \
						--admin_email=${ADMIN_EMAIL} \
						--skip-email \
						--path="/var/www/html/wordpress" \
						--allow-root

	wp user create		${USER1_LOGIN} \
						${USER1_MAIL} \
						--user_pass=${USER1_PASS} \
						--role=subscriber \
						--display_name=${USER1_LOGIN} \
						--porcelain \
						--path="/var/www/html/wordpress" \
						--allow-root

	wp plugin install	redis-cache --activate --allow-root

	wp plugin update	--all --allow-root

	wp config set WP_REDIS_HOST redis --add --type=constant --allow-root

	wp config set WP_REDIS_PORT 6379 --add --type=constant --allow-root

	chmod 755 /var/www/html/wordpress/wp-content

	wp redis enable --allow-root

fi

exec /usr/sbin/php-fpm82 -F
