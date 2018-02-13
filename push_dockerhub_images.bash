#!/bin/bash
set -ex

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

LIST_OF_ROS_DISTROS="kinetic"

for ROS_DISTRO in ${LIST_OF_ROS_DISTROS}; do
  IMAGE_NAME=ariac-server-${ROS_DISTRO}
  TAG_NAME=ariac2-server-${ROS_DISTRO}:ariac2_0.0-gazebo_7.7
  docker tag ${IMAGE_NAME} ariac/${TAG_NAME}
  docker push ariac/${TAG_NAME}
  TAG_NAME=ariac2-server-${ROS_DISTRO}:latest
  docker tag ${IMAGE_NAME} ariac/${TAG_NAME}
  docker push ariac/${TAG_NAME}

  IMAGE_NAME=ariac-competitor-base-${ROS_DISTRO}
  TAG_NAME=ariac2-competitor-base-${ROS_DISTRO}:ariac2_0.0
  docker tag ${IMAGE_NAME} ariac/${TAG_NAME}
  docker push ariac/${TAG_NAME}
  TAG_NAME=ariac2-competitor-base-${ROS_DISTRO}:latest
  docker tag ${IMAGE_NAME} ariac/${TAG_NAME}
  docker push ariac/${TAG_NAME}
done
