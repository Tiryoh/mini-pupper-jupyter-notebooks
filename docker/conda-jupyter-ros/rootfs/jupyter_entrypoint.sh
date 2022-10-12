#!/bin/bash
set -e

source /opt/miniconda3/bin/activate robostackenv

if [ -e /opt/miniconda3/envs/robostackenv/lib/python3.8/site-packages/jupyter_ros_server/static/settings.json ]; then
    sudo chown $(whoami):$(whoami) /opt/miniconda3/envs/robostackenv/lib/python3.8/site-packages/jupyter_ros_server/static/settings.json
fi

jupyter lab --notebook-dir=/workspace --ip 0.0.0.0 --no-browser --allow-root $@

