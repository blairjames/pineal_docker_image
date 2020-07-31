FROM alpine:latest
RUN \
    apk update && apk upgrade
RUN \
    apk add --no-cache \
    curl \ 
    util-linux
RUN \
    alias c="clean" && \
    alias l="ls -lrth"

ENTRYPOINT ["/bin/sh"]
