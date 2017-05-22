#!/bin/bash -x
set -e

# Uncoment this line to rebuild without cache
#DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ $# -lt 1 ]]; then
  echo "$0 <ros-distro-to-build>"
  exit 1
fi

ROS_DISTRO_BUILD_TIME=${1}

case ${ROS_DISTRO_BUILD_TIME} in
  indigo)
    UBUNTU_DISTRO_TO_BUILD=trusty
    ;;
  kinetic)
    UBUNTU_DISTRO_TO_BUILD=xenial
    ;;
  *)
    echo "ROS distribution unsupported: ${ROS_DISTRO_BUILD_TIME}"
    exit 1 
esac

# Set the proper Dockerfile from distro Dockerfiles
cp ${DIR}/gzserver/Dockerfile_${UBUNTU_DISTRO_TO_BUILD} \
   ${DIR}/gzserver/Dockerfile

docker_images="gzserver gazebo gazebo-ros nvidia-gazebo-ros ariac-server"

for docker_img in ${docker_images}; do
  echo " Build image: ${docker_img} "

  case ${docker_img} in
    'ariac-server')
      DOCKER_ARGS="--build-arg ROS_DISTRO_BUILD_TIME=${ROS_DISTRO_BUILD_TIME}"
      ;;
    'gazebo-ros')
      DOCKER_ARGS="--build-arg ROS_DISTRO_BUILD_TIME=${ROS_DISTRO_BUILD_TIME} \
                   --build-arg UBUNTU_DISTRO_TO_BUILD=${UBUNTU_DISTRO_TO_BUILD}"
      ;;
    'gzserver')
      # To be sure about getting indigo or xenial right from the base
      # no-cache.
      DOCKER_ARGS="--no-cache"
      ;;
    *)
      DOCKER_ARGS=""
  esac

  docker build ${DOCKER_ARGS} \
    --tag ${docker_img}:latest \
      $DIR/${docker_img}
done
