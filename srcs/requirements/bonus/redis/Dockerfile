
FROM	alpine:3.19.1

RUN		apk update ; apk upgrade ; \
		apk add --no-cache redis

COPY tools/launch-redis.sh /tmp/launch-redis.sh

EXPOSE 6379

ENTRYPOINT [ "sh", "/tmp/launch-redis.sh" ]
