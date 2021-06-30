#!/usr/bin/env bash
set -eu
script_folder=$(realpath $(dirname $0))

image_name=lfs-build

docker build \
  --cache-from=${image_name}:latest \
  -t ${image_name} \
  -f "${script_folder}/Dockerfile" \
  "${script_folder}/../"
  