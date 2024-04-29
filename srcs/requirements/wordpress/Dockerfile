
FROM	alpine:3.19.1

RUN	apk update ; apk upgrade ; apk add --no-cache \
				bash				\
				wget				\
				mariadb-client

RUN		apk add --no-cache \
				php82 \
				php82-fpm \
				php82-bcmath \
				php82-bz2 \
				php82-calendar \
				php82-cli \
				php82-ctype \
				php82-curl \
				php82-dom \
				php82-exif \
				php82-fileinfo \
				php82-gd \
				php82-gmp \
				php82-iconv \
				php82-imap \
				php82-intl \
				php82-json \
				php82-mbstring \
				php82-mysqli \
				php82-mysqlnd \
				php82-openssl \
				php82-pcntl \
				php82-pdo \
				php82-pdo_mysql \
				php82-pdo_pgsql \
				php82-pdo_sqlite \
				php82-pgsql \
				php82-phar \
				php82-posix \
				php82-session \
				php82-shmop \
				php82-simplexml \
				php82-soap \
				php82-sockets \
				php82-sodium \
				php82-sqlite3 \
				php82-sysvsem \
				php82-sysvshm \
				php82-tokenizer \
				php82-xml \
				php82-xmlreader \
				php82-xmlwriter \
				php82-xsl \
				php82-zip \
				php82-zlib
	
		
RUN		adduser -S nginx && addgroup -S nginx
COPY	conf/php-fpm.conf /etc/php82/php-fpm.conf
COPY	conf/www.conf /etc/php82/php-fpm.d/www.conf

RUN		sed -i 's/listen = 127.0.0.1:9000/listen = 9000/g' /etc/php82/php-fpm.d/www.conf

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/bin/wp

WORKDIR /var/www/html/wordpress

COPY tools/configure.sh /tmp/configure.sh

EXPOSE 9000

EXPOSE 6379

ENTRYPOINT [ "bash", "/tmp/configure.sh" ]