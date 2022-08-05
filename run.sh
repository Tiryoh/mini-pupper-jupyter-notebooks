#!/bin/bash -eu

#DOCKER=tiryoh/pytorch:1.12.1
#DOCKER=tiryoh/jupyter-ros:noetic
DOCKER=tiryoh/conda-jupyter-ros:noetic

set -x

#       --privileged \

docker run --rm -it -u $(id -u):$(id -g) \
       --device /dev/video0 \
       --group-add video \
       -v /dev/bus/usb:/dev/bus/usb --device-cgroup-rule='c 189:* rmw' \
       -p 8888:8888 -v $(pwd)/notebook:/workspace \
       --network=host \
       ${DOCKER}
#       ${DOCKER} \
#       jupyter lab --notebook-dir=/workspace --ip 0.0.0.0 --no-browser
