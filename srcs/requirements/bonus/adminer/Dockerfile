
FROM	alpine:3.19.1

RUN		apk update ; apk upgrade ; \
		apk add --no-cache \
			php82 \
			php82-session \
			php82-mysqli \
			php82-pdo_mysql

RUN		mkdir /var/www ; \
		wget -O /var/www/adminer.php \
		https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-en.php

EXPOSE 8080

CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/"]
