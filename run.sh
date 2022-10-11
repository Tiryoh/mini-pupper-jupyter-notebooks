#!/bin/bash -eu

# Check if the user belongs to "docker" group
groups | grep -q docker && SUDO="" || SUDO="sudo"

DOCKER=ghcr.io/tiryoh/conda-jupyter-ros:noetic
JUPYTER_TOKEN=$(sed -e "s/://g" /sys/class/net/wlan0/address)

echo "========================================="
echo JupyterLab Token: $JUPYTER_TOKEN
echo "========================================="

set -x

#       --privileged \
#       --device /dev/video0 \
#       --group-add video \
#       -v /dev/bus/usb:/dev/bus/usb --device-cgroup-rule='c 189:* rmw' \
#       -p 8888:8888 \
#       ${DOCKER} \
#       jupyter lab --notebook-dir=/workspace --ip 0.0.0.0 --no-browser

$SUDO docker run --rm -it -u $(id -u):$(id -g) \
       -v $(pwd)/notebook:/workspace \
       --network=host \
       ${DOCKER} \
       bash -c "/jupyter_entrypoint.sh --ServerApp.token=${JUPYTER_TOKEN}"

