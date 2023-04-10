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
  echo "alias l='ls -larth'" >> $HOME/.bashrc && \
  echo "alias c='clear'" >> $HOME/.bashrc && \
  echo "alias up='apk update && apk upgrade'" >> $HOME/.bashrc && \
  echo "alias s='apk search'" >> $HOME/.bashrc && \
  echo "alias in='apk add'" >> $HOME/.bashrc

HEALTHCHECK --interval=20s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f google.com.au || exit 1

ENTRYPOINT ["/bin/bash"]
