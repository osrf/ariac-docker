#!/bin/bash -x
set -e

# Uncoment this line to rebuild without cache
#DOCKER_ARGS="--no-cache"

set -x

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

docker_images="gzserver gazebo gazebo-ros nvidia-gazebo-ros ariac-server"

for docker_img in ${docker_images}; do
  echo " Build image: ${docker_img} "

  case ${docker_img} in
    'ariac-server')
      DOCKER_ARGS="--no-cache"
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
      DOCKER_ARGS=""
      ;;
    'gzserver')
      DOCKER_ARGS=""
      ;;
    *)
      DOCKER_ARGS=""
  esac

  docker build ${DOCKER_ARGS} \
    --tag ${docker_img}-melodic:latest \
      $DIR/${docker_img}
done
