
FROM	alpine:3.19.1

RUN	apk update ; apk upgrade ; apk add --no-cache \
				wget				

RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz -O ngrok.tgz && \
    tar x -f /ngrok.tgz && \
    rm -f /ngrok.tgz

RUN chmod +x ngrok

COPY /tools/ngrok-configure.sh /tmp/ngrok-configure.sh

ENTRYPOINT [ "sh", "/tmp/ngrok-configure.sh" ]
