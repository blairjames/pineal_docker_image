FROM alpine:latest
RUN \
    apk update && apk upgrade
RUN \
    apk add --no-cache \
    curl
RUN \
    alias c="clean" && \
    alias l="ls -lrth"

ENTRYPOINT ["/usr/bin/env sh"]
