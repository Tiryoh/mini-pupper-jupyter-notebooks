#!/bin/bash -eu

SRC_DIR=$(cd $(dirname ${BASH_SOURCE:-$0}); pwd)

PYTORCH_VERSION=1.12.1

docker build -t tiryoh/pytorch:$PYTORCH_VERSION $SRC_DIR
