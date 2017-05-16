#!/usr/bin/env bash

DOCKER_ARGS=""
# Uncoment this line to rebuild without cache
#DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build ${DOCKER_ARGS} -t competitor-container ${DIR}
