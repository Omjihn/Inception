
FROM	alpine:3.19.1

RUN		apk update ; apk upgrade ; \
		apk add --no-cache vsftpd

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/configure-vsftpd.sh /tmp/configure-vsftpd.sh

CMD [ "sh", "/tmp/configure-vsftpd.sh" ]
