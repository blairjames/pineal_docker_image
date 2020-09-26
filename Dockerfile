FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add --no-cache \
    vim \
    curl \ 
    shadow \
    git \
    util-linux \
    bash
ENTRYPOINT ["/bin/bash"]

