
FROM	alpine:3.19.1

RUN		apk update ; apk upgrade ; \
		apk add --no-cache \
			openssl \
			vsftpd

RUN		openssl req -newkey rsa:4096 \
					-x509 \ 
					-days 365 \
					-nodes \
					-keyout /etc/ssl/ssl.key \
					-out /etc/ssl/ssl.crt \
					-subj "/C=FR/ST=PO/L=Perpignan/O=42/OU=42/CN=gbricot.42.fr/UID=gbricot"

COPY conf/vsftpd.conf /tmp/vsftpd.conf

COPY tools/configure-vsftpd.sh /tmp/configure-vsftpd.sh

CMD [ "sh", "/tmp/configure-vsftpd.sh" ]
