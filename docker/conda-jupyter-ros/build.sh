#!/bin/bash -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

docker build -t ghcr.io/tiryoh/conda-jupyter-ros:noetic $SRC_DIR
