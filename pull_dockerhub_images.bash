#!/bin/bash
set -e

ROS_DISTRO=${1-kinetic}

case ${ROS_DISTRO} in
  kinetic)
    echo Using ROS distro "kinetic" on ubuntu distro "xenial"
    ;;
  *)
    echo "ROS distribution unsupported: ${ROS_DISTRO}"
    exit 1
esac
echo "Pulling the ARIAC competition images from dockerhub"

docker pull ariac/ariac2-server-${ROS_DISTRO}:latest
docker pull ariac/ariac2-competitor-base-${ROS_DISTRO}:latest
