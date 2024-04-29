
FROM	alpine:3.19.1

RUN	apk update && apk upgrade && apk add --no-cache \
        mariadb \
        mariadb-client

COPY tools/configure.sh /tmp/configure.sh
RUN		chmod +x /tmp/configure.sh

COPY conf/my.cnf	/etc/mysql/my.cnf

EXPOSE 3306

ENTRYPOINT ["sh", "/tmp/configure.sh"]