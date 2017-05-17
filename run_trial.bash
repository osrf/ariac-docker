#!/usr/bin/env bash

CONTAINER_NAME=ariac-server-system
LOG_DIR=/ariac/logs
HOST_LOG_DIR=${LOG_DIR}
./ariac-server/run_container.bash ${CONTAINER_NAME} ariac-server \
  "-v /home/dhood/ariac_ws/ariac-docker/example_team:/team_config -v /home/dhood/ariac_ws/ariac-docker/logs:/ariac/logs -e ARIAC_EXIT_ON_COMPLETION=1" \
  "/run_ariac_task.sh /opt/ros/indigo/share/osrf_gear/config/qual2a.yaml /opt/ros/indigo/share/osrf_gear/config/sample_user_config.yaml ${LOG_DIR}"
