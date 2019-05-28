#!/usr/bin/env bash
set -e

# Comment this line to rebuild using the cache
DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker build ${DOCKER_ARGS} -t ariac-competitor-base-melodic:latest ${DIR}/ariac-competitor-base
