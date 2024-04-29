
FROM	alpine:3.19.1

RUN		apk update ; apk upgrade ; \
		apk add --no-cache \
				nginx \
				openssl ; \
		mkdir -p /etc/nginx ; \
		mkdir -p /etc/nginx/ssl ; \
		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
					-out /etc/nginx/ssl/ssl.crt \
					-keyout /etc/nginx/ssl/ssl.key \
					-subj "/C=FR/ST=PO/L=Perpignan/O=42/OU=42/CN=gbricot.42.fr/UID=gbricot"

COPY conf/nginx.conf /etc/nginx/nginx.conf

COPY static_website/ /var/www/html

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
