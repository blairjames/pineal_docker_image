# Pineal

![image](https://user-images.githubusercontent.com/32350627/230576949-e817c15c-db53-4839-bdc1-f755d4a46468.png)

### Latest Alpine, fully patched with some extra tools and tweaks.
##### Usage:
``` docker run -it --rm docker.io/blairy/pineal:latest ```


<br/>

---

### Dockerfile

```bash
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
```

---

### Build Script

```bash
#!/usr/bin/env bash

build() {
  local path
  local image_name
  path="$1"
  image_name="$2"
  readonly path
  readonly image_name
  sudo docker build --compress --pull \
    -t "${image_name}" "${path}"
}

push() {
  local image
  image="$1"
  readonly image
  sudo docker push "${image}"
}

main() {
  local path
  local timestamp
  local image_name
  local latest 
  latest="docker.io/blairy/pineal:latest"
  readonly latest
  path="${USERHOME}"/docker/pineal
  readonly path
  timestamp=$(/usr/bin/date +%Y%m%d_%H%M)
  readonly timestamp
  echo 'Timestamp: '"${timestamp}"
  image_name='docker.io/blairy/pineal:'"${timestamp}"
  readonly image_name
  echo 'image_name: '"${image_name}"
  build "${path}" "${image_name}" || exit 1
  push "${image_name}" || exit 1
  build "${path}" "${latest}" || exit 1
  push "${latest}" || exit 1
}

main "$@"
```

