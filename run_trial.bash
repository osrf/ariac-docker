#!/usr/bin/env bash

TEAM_NAME=example_team
TRIAL_NAME=example_trial1
CONTAINER_NAME=ariac-server-system
HOST_LOG_DIR=`pwd`/logs/${TEAM_NAME}/${TRIAL_NAME}
echo ${HOST_LOG_DIR}
mkdir -p ${HOST_LOG_DIR}

TEAM_CONFIG_DIR=`pwd`/${TEAM_NAME}
echo ${TEAM_CONFIG_DIR}
COMP_CONFIG_DIR=`pwd`/comp_configs

LOG_DIR=/ariac/logs
./ariac-server/run_container.bash ${CONTAINER_NAME} ariac-server \
  "-v ${TEAM_CONFIG_DIR}:/team_config \
  -v ${COMP_CONFIG_DIR}:/ariac/comp_configs \
  -v ${HOST_LOG_DIR}:/ariac/logs \
  -e ARIAC_EXIT_ON_COMPLETION=1" \
  "/run_ariac_task.sh /ariac/comp_configs/${TRIAL_NAME}.yaml /team_config/team_config.yaml ${LOG_DIR}" &

sleep 10
./ariac-competitor/run_competitor_container.bash

# <call end_competition service from within competitor container, then kill competitor container>

echo "Killing ARIAC server"
docker kill ${CONTAINER_NAME}

# Make the log playable
sudo chown $USER ${HOST_LOG_DIR}/gazebo/state.log
