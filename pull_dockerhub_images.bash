#!/bin/bash
set -e

ROS_DISTRO=${1-indigo}

case ${ROS_DISTRO} in
  indigo)
    echo Using ROS distro "indigo" on ubuntu distro "trusty"
    ;;
  kinetic)
    echo Using ROS distro "kinetic" on ubuntu distro "xenial"
    ;;
  *)
    echo "ROS distribution unsupported: ${ROS_DISTRO}"
    exit 1
esac
echo "Pulling the ARIAC competition images from dockerhub"

docker pull ariac/ariac-server-${ROS_DISTRO}
docker pull ariac/ariac-competitor-base-${ROS_DISTRO}
