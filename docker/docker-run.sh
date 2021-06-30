#!/usr/bin/env bash
set -eu
script_folder=$(realpath $(dirname $0))

image_name=lfs-build
container_name=lfs-built

docker run --rm -it \
  --name ${container_name} \
  -e CCACHE_DIR=/ccache \
  -v "${script_folder}/../:/project" \
  -v "${script_folder}/../volumes/ccache:/ccache" \
  -d ${image_name} \
  "mkdir -p ./build \
  && cd ./build \
  && cmake .. \
    -DENABLE_TESTS=ON \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  && tail -f /dev/null"
