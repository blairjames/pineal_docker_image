FROM alpine:latest

# Upgrade and install packages
RUN \
    apk update --no-cache \ 
    && apk upgrade \
    && apk add \
      curl \
      git \
      util-linux \
      wget \
      bash \
      util-linux-misc 

# Add command aliases
RUN \
  touch $HOME/.bashrc && chmod 755 $HOME/.bashrc && \
  echo "alias l='ls -larth'" >> $HOME/.bashrc && \
  echo "alias c='clear'" >> $HOME/.bashrc && \
  echo "alias up='apk update && apk upgrade'" >> $HOME/.bashrc && \
  echo "alias s='apk search'" >> $HOME/.bashrc && \
  echo "alias in='apk add'" >> $HOME/.bashrc

HEALTHCHECK --interval=15s --timeout=5s --start-period=10s --retries=2 \
  CMD /bin/bash -c 'curl -f google.com.au || exit 1' 

ENTRYPOINT ["/bin/bash"]
