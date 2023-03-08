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
  
# Add nonpriv user with sudo access to APK
ENV USER pineal
ENV HOME /home/$USER
ENV CMDS /sbin/apk
RUN \
    addgroup -g 1000 $USER && \
    adduser -G $USER --home $HOME --shell '/bin/bash' $USER -D && \
    echo "$USER ALL=(ALL:ALL) NOPASSWD: $CMDS" > /etc/sudoers.d/$USER && \
    chmod 440 /etc/sudoers.d/$USER && \ 
    echo "alias l='ls -lrth'" >> $HOME/.bashrc && \
    echo "alias c='clear'" >> $HOME/.bashrc

    USER $USER
    WORKDIR $HOME

ENTRYPOINT ["/bin/bash"]
