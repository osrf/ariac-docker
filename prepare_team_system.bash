#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEAM_NAME=${1}

if [[ $# -lt 1 ]]; then
  echo "$0 <team-image-dir-name> [<ros-distro-to-build>=indigo]"
  exit 1
fi

if [[ ! -d ${TEAM_NAME} ]]; then
  echo "Can not find team directory in path ${TEAM_NAME}"
  exit 1
fi

echo "Preparing the team system setup for team ${TEAM_NAME}"
if [[ $# -lt 1 ]]; then
  echo "$0 "
  exit 1
fi

ROS_DISTRO_BUILD_TIME=${2-indigo}

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
cp ${DIR}/ariac-competitor/Dockerfile_${UBUNTU_DISTRO_TO_BUILD} \
   ${DIR}/ariac-competitor/Dockerfile

${DIR}/ariac-competitor/build_competitor_image.bash ${TEAM_NAME}
