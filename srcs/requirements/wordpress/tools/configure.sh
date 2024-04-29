#!bin/bash

sleep 3

if [ ! -e /var/www/html/wordpress/wp-config.php ]; then

	wp cli update		--yes --allow-root

	wp core download	--allow-root

	wp config create	--dbname=$SQL_DATABASE \
						--dbuser=$SQL_USER \
						--dbpass=$SQL_PASSWORD \
						--dbhost=mariadb \
						--path="/var/www/html/wordpress" \
						--allow-root

	wp core install		--url=localhost/ \
						--title=${SITE_TITLE} \
						--admin_user=${ADMIN_USER} \
						--admin_password=${ADMIN_PASSWORD} \
						--admin_email=${ADMIN_EMAIL} \
						--path="/var/www/html/wordpress" \
						--allow-root

	wp user create		${USER1_LOGIN} \
						--user_pass=${USER1_PASS} \
						--role=subscriber \
						--display_name=${USER1_LOGIN} \
						--porcelain \
						--path="/var/www/html/wordpress" \
						--allow-root

	chmod -R 755 wp-content/uploads/
	chmod -R 755 wp-content/plugins/
	chmod -R 755 wp-content/themes/

	wp plugin install	redis-cache --activate --allow-root

	wp plugin update	--all --allow-root

	wp theme install	"bravada" \
						--path="/var/www/html/wordpress" \
						--activate \
						--allow-root

	wp theme status		"bravada" --allow-root

	wp config set WP_REDIS_HOST redis --add --type=constant --allow-root

	wp config set WP_REDIS_PORT 6379 --add --type=constant --allow-root

fi

wp redis enable --allow-root

exec /usr/sbin/php-fpm82 -F
