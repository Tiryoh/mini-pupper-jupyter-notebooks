#!/bin/bash -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

docker build -t tiryoh/conda-jupyter-ros:noetic $SRC_DIR
