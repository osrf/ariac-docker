#!/bin/bash -x
set -e

# Uncoment this line to rebuild without cache
#DOCKER_ARGS="--no-cache"

set -x

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

docker_images="gzserver gazebo gazebo-ros nvidia-gazebo-ros ariac-server"

for docker_img in ${docker_images}; do
  echo " Build image: ${docker_img} "

  case ${docker_img} in
    'ariac-server')
      DOCKER_ARGS="--build-arg ROS_DISTRO_BUILD_TIME=${ROS_DISTRO_BUILD_TIME}"
      ;;
    'gazebo')
      USERID=`id -u $USER`
      # If the script is run by root, do no pass 0 as the USERID to create the
      # ariac-user. The Dockerfile defaults it to 1000
      if [[ ${USERID} != 0 ]]; then
        DOCKER_ARGS="--build-arg USERID=${USERID}"
      fi
      ;;
    'gazebo-ros')
      DOCKER_ARGS="--build-arg ROS_DISTRO_BUILD_TIME=${ROS_DISTRO_BUILD_TIME} \
                   --build-arg UBUNTU_DISTRO_TO_BUILD=${UBUNTU_DISTRO_TO_BUILD}"
      ;;
    'gzserver')
      DOCKER_ARGS="--build-arg UBUNTU_DISTRO_TO_BUILD=${UBUNTU_DISTRO_TO_BUILD}"
      ;;
    *)
      DOCKER_ARGS=""
  esac


    # Set the proper base image in the Dockerfile according to the ROS distro
    cp ${DIR}/${docker_img}/Dockerfile_generic \
       ${DIR}/${docker_img}/Dockerfile

  if [ ${docker_img} = "gzserver" ]; then
    sed -i "s+^FROM.*$+FROM ubuntu:${UBUNTU_DISTRO_TO_BUILD}+" \
      ${DIR}/${docker_img}/Dockerfile
  else
    sed -i "s/:latest/-${ROS_DISTRO_BUILD_TIME}:latest/" \
      ${DIR}/${docker_img}/Dockerfile
  fi

  # Tag the image according to the ROS distro
  docker build ${DOCKER_ARGS} \
    --tag ${docker_img}-${ROS_DISTRO_BUILD_TIME}:latest \
      $DIR/${docker_img}
done
