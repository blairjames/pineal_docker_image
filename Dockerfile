FROM alpine:latest
RUN apk update && apk upgrade && \
    apk add --no-cache \
    curl \ 
    git \
    util-linux \
    bash
RUN echo "alias l='ls -lrth'" >> /root/.bashrc && \
    echo "alias c='clear'" >> /root/.bashrc && \
    echo "alias ll='ls -lth'" >> /root/.bashrc && \
    echo "alias la='ls -larth'" >> /root/.bashrc
ENTRYPOINT ["/bin/bash"]

