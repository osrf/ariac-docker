#!/usr/bin/env bash

CONTAINER="competitor-container"
IMAGE_NAME="user-ariac"
DOCKER_EXTRA_ARGS=""
COMMAND=$1

NETWORK="ariac-network"
IP="172.18.0.20"
SERVER_IP="172.18.0.22"

docker run --rm --name ${CONTAINER} \
  -e GAZEBO_MASTER_URI=http://${SERVER_IP}:11346 \
  -e ROS_IP=${IP} \
  -e ROS_MASTER_URI=http://${SERVER_IP}:11311 \
  --ip ${IP} \
  --net ${NETWORK} \
  ${IMAGE_NAME} \
  ${COMMAND}
