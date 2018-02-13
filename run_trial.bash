#!/usr/bin/env bash

set -e

TEAM_NAME=$1
TRIAL_NAME=$2

# Constants.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

CONTAINER_NAME=ariac-server-system

# Create the directory that logs will be copied into. Since the userid of the user in the container
# might different to the userid of the user running this script, we change it to be public-writable.
HOST_LOG_DIR=`pwd`/logs/${TEAM_NAME}/${TRIAL_NAME}
echo "Creating directory: ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}
chmod 777 ${HOST_LOG_DIR}

# TODO: don't rely on script being run in the root directory
# TODO: error checking for case when files can't be found
TEAM_CONFIG_DIR=`pwd`/team_config/${TEAM_NAME}
echo "Using team config: ${TEAM_CONFIG_DIR}/team_config.yaml"
COMP_CONFIG_DIR=`pwd`/trial_config
echo "Using comp config: ${COMP_CONFIG_DIR}/${TRIAL_NAME}.yaml"

ROS_DISTRO=kinetic
# ROS_DISTRO_FILE=${TEAM_CONFIG_DIR}/ros_distro.txt
# if [ -f $ROS_DISTRO_FILE ]; then
#   ROS_DISTRO=`cat $ROS_DISTRO_FILE`
#   echo "Using ROS distro of: ${ROS_DISTRO}"
# else
#   ROS_DISTRO=indigo
#   echo "ros_distro.txt not found. Assuming ROS distro of: indigo"
# fi

LOG_DIR=/ariac/logs

# Ensure any previous containers are killed and removed.
./kill_ariac_containers.bash

# Create the network for the containers to talk to each other.
./ariac-competitor/ariac_network.bash

# Start the competitors container and let it run in the background.
COMPETITOR_IMAGE_NAME="ariac-competitor-${TEAM_NAME}"
./ariac-competitor/run_competitor_container.bash ${COMPETITOR_IMAGE_NAME} "/run_team_system_with_delay.bash" &

# Start the competition server. When the trial ends, the container will be killed.
# The trial may end because of time-out, because of completion, or because the user called the
# /ariac/end_competition service.
./ariac-server/run_container.bash ${CONTAINER_NAME} ariac/ariac2-server-${ROS_DISTRO}:latest \
  "-v ${TEAM_CONFIG_DIR}:/team_config \
  -v ${COMP_CONFIG_DIR}:/ariac/trial_config \
  -v ${HOST_LOG_DIR}:${LOG_DIR} \
  -e ARIAC_EXIT_ON_COMPLETION=1" \
  "/run_ariac_task.sh /ariac/trial_config/${TRIAL_NAME}.yaml /team_config/team_config.yaml ${LOG_DIR}"

# Copy the ROS log files from the competitor's container.
echo "Copying ROS log files from competitor container..."
docker cp --follow-link ariac-competitor-${TEAM_NAME}-system:/root/.ros/log/latest $HOST_LOG_DIR/ros-competitor
echo -e "${GREEN}OK${NOCOLOR}"

./kill_ariac_containers.bash

exit 0
