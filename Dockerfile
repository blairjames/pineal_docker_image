FROM alpine:latest

# Upgrade and install packages
RUN \
    apk update --no-cache && \ 
    apk upgrade --no-cache && \
    apk add --no-cache \
    curl \ 
    git \
    util-linux \
    wget \
    bash \
    sudo
  
USER root

ENTRYPOINT ["/bin/bash"]
