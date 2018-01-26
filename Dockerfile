FROM alpine:latest
MAINTAINER osyed - https://github.com/osyed

COPY assets /tmp/
RUN apk update && \
    apk add nodejs && \
    apk add autoconf && \
    apk add automake && \
    apk add build-base && \
    apk add libtool && \
    apk add python && \
    npm install -g iced-coffee-script && \
    adduser -D -u 1000 user && \
    su user /tmp/user.sh && \
# clean up
    apk del python && \
    apk del libtool && \
    apk del build-base && \
    apk del automake && \
    apk del autoconf && \
    ls

RUN cp /tmp/entrypoint /entrypoint && \
    echo "::once:/entrypoint" > /etc/inittab && \
    ls

#USER user
WORKDIR /home/user

EXPOSE 3000
VOLUME ["/data"]
ENTRYPOINT ["/sbin/init"]



