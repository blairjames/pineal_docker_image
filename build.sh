#!/usr/bin/env bash

build() {
  local path
  path=$1
  echo $path
  sudo docker build -t docker.io/blairy/pineal:latest $path
}

push() {
  docker push blairy/pineal:latest
}

main() {
  local path
  path=$1
  build $path;
  push;
  echo "Done! $(date)" >> $path/log  
}

main $1;
