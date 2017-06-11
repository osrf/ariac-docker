#!/bin/bash
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LIST_OF_ROS_DISTROS="indigo kinetic"

for ROS_DISTRO in ${LIST_OF_ROS_DISTROS}; do
  IMAGE_NAME=ariac-server-${ROS_DISTRO}
  docker tag ${IMAGE_NAME} ariac/${IMAGE_NAME}:latest
  docker push ariac/${IMAGE_NAME}:latest
  IMAGE_NAME=ariac-competitor-base-${ROS_DISTRO}
  docker tag ${IMAGE_NAME} ariac/${IMAGE_NAME}:latest
  docker push ariac/${IMAGE_NAME}:latest
done
