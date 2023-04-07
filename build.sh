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
  local image_name
  path="${USERHOME}"/docker/pineal
  image_name="docker.io/blairy/pineal:latest"
  readonly path
  readonly image_name
  build "${path}" "${image_name}" || exit 1
  push "${image_name}" || exit 1
}

main "$@"
