#!/usr/bin/env bash

CONTAINER="competitor-container"
IMAGE_NAME="user-ariac"
DOCKER_EXTRA_ARGS=""
COMMAND=$1

docker run --rm --name ${CONTAINER} \
  --env-file ./env.list \
  --net ariac-network \
  --ip 172.18.0.20 \
  ${IMAGE_NAME} \
  ${COMMAND}
