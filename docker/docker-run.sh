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
  --cap-add SYS_ADMIN \
  --security-opt "apparmor=unconfined" \
  --device /dev/loop0:/dev/loop0 \
  --device /dev/loop1:/dev/loop1 \
  --device /dev/loop2:/dev/loop2 \
  --device /dev/loop3:/dev/loop3 \
  --device /dev/loop4:/dev/loop4 \
  --device /dev/loop5:/dev/loop5 \
  --device /dev/loop6:/dev/loop6 \
  --device /dev/loop7:/dev/loop7 \
  --device /dev/loop-control:/dev/loop-control \
  -d ${image_name} \
  "mkdir -p ./build \
  && cd ./build \
  && cmake .. \
    -DENABLE_TESTS=ON \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
  && make \
  && make install \
  && cd ../tests/ \
  && mkdir -p /mnt/hdd{0..3} \
  && ./setup_machine.sh setup /mnt/hdd{1..3} \
  && tail -f /dev/null"
