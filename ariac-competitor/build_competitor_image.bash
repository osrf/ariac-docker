#!/usr/bin/env bash

set -x

DOCKER_ARGS=""
# Uncoment this line to rebuild without cache
# TODO: expose this as an argument
#DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEAM_NAME=$1
TEAM_CONFIG_DIR=${DIR}/../${TEAM_NAME}

ROS_DISTRO_FILE=${TEAM_CONFIG_DIR}/ros_distro.txt
if [ -f $ROS_DISTRO_FILE ]; then
  ROS_DISTRO_BUILD_TIME=`cat $ROS_DISTRO_FILE`
  echo "Using ROS distro of: ${ROS_DISTRO_BUILD_TIME}"
else
  ROS_DISTRO_BUILD_TIME=indigo
  echo "ros_distro.txt not found. Assuming ROS distro of: indigo"
fi

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

# Create a Dockerfile from the template
cp ${DIR}/ariac-competitor-clean/Dockerfile_trusty \
   ${DIR}/ariac-competitor-clean/Dockerfile
# Set the proper base image in the Dockerfile according to the ROS distro
sed -i "s+^FROM.*$+FROM osrf/ros:${ROS_DISTRO_BUILD_TIME}-desktop-full+" \
   ${DIR}/ariac-competitor-clean/Dockerfile


# TODO: pass the path of the team's scripts as a parameter of the Dockerfile,
# instead of copying them temporarily so they always have the same location.
echo "Copying team scripts temporarily"
cp ${TEAM_CONFIG_DIR}/build_team_system.bash ${DIR}/ariac-competitor/build_team_system.bash
cp ${TEAM_CONFIG_DIR}/run_team_system.bash ${DIR}/ariac-competitor/run_team_system.bash

docker build ${DOCKER_ARGS} -t ariac-competitor-clean:latest ${DIR}/ariac-competitor-clean
docker build ${DOCKER_ARGS} -t ariac-competitor:latest ${DIR}/ariac-competitor

echo "Removing temporary team scripts"
rm ${DIR}/ariac-competitor/build_team_system.bash
rm ${DIR}/ariac-competitor/run_team_system.bash
