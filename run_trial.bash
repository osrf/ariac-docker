#!/usr/bin/env bash

set -e

TEAM_NAME=$1
TRIAL_NAME=$2

#TODO: generate unique container names based on input arguments
CONTAINER_NAME=ariac-server-system

HOST_LOG_DIR=`pwd`/logs/${TEAM_NAME}/${TRIAL_NAME}
echo "Creating directory: ${HOST_LOG_DIR}"
mkdir -p ${HOST_LOG_DIR}

# TODO: don't rely on script being run in the root directory
# TODO: error checking for case when files can't be found
TEAM_CONFIG_DIR=`pwd`/${TEAM_NAME}
echo "Using team config: ${TEAM_CONFIG_DIR}/team_config.yaml"
COMP_CONFIG_DIR=`pwd`/comp_configs
echo "Using comp config: ${COMP_CONFIG_DIR}/${TRIAL_NAME}.yaml"

LOG_DIR=/ariac/logs

# Create the network for the containers to talk to each other.
./ariac-competitor/ariac_network.bash

# Start the competitors container and let it run in the background.
#TODO: parameterize the container name
./ariac-competitor/run_competitor_container.bash &

# Start the competition server. When the trial ends, the container will be killed.
# The trial may end because of time-out, because of completion, or because the user called the
# /ariac/end_competition service.
./ariac-server/run_container.bash ${CONTAINER_NAME} ariac-server \
  "-v ${TEAM_CONFIG_DIR}:/team_config \
  -v ${COMP_CONFIG_DIR}:/ariac/comp_configs \
  -v ${HOST_LOG_DIR}:${LOG_DIR} \
  -e ARIAC_EXIT_ON_COMPLETION=1" \
  "/run_ariac_task.sh /ariac/comp_configs/${TRIAL_NAME}.yaml /team_config/team_config.yaml ${LOG_DIR}"; echo $?

docker kill ariac-competitor-system

# Make the log playable
#TODO: figure out why the ownership of the state log is root and resolve.
echo "Changing ownership of gazebo state log"
sudo chown $USER ${HOST_LOG_DIR}/gazebo/state.log
