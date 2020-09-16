FROM alpine:latest
RUN apk update && apk upgrade
RUN apk add --no-cache \
    curl \ 
    git \
    util-linux \
    bash
ENTRYPOINT ["/bin/bash"]

