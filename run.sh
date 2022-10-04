#!/bin/bash -eu

DOCKER=tiryoh/conda-jupyter-ros:noetic

set -x

#       --privileged \
#       --device /dev/video0 \
#       --group-add video \
#       -v /dev/bus/usb:/dev/bus/usb --device-cgroup-rule='c 189:* rmw' \
#       -p 8888:8888 \
#       ${DOCKER} \
#       jupyter lab --notebook-dir=/workspace --ip 0.0.0.0 --no-browser

docker run --rm -it -u $(id -u):$(id -g) \
       -v $(pwd)/notebook:/workspace \
       --network=host \
       ${DOCKER}
