#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Constants.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

TEAM_NAME=$1

# Get the available Gazebo log files.
get_list_of_gazebo_logs()
{
  CURRENT_DIR=`pwd`
  all_names=`find $CURRENT_DIR -name state.log`
  echo $all_names
}

echo -e "
${GREEN}Generating all videos for team: ${TEAM_NAME}${NOCOLOR}"

for GAZEBO_LOG in $(get_list_of_gazebo_logs); do
  echo "Generating video: ${GAZEBO_LOG}..."
  TRIAL_NAME=`basename ${GAZEBO_LOG%/gazebo/state.log}`
  OUTPUT_DIR=logs/${TEAM_NAME}/${TRIAL_NAME}
  mkdir -p ${OUTPUT_DIR}
  ./generate_video.bash "${GAZEBO_LOG}" "${OUTPUT_DIR}/output.ogv"
  exit_status=$?
  if [ $exit_status -eq 0 ]; then
    echo -e "${GREEN}OK.${NOCOLOR}"
  else
    echo -e "${RED}TRIAL FAILED: ${TEAM_NAME}/${TRIAL_NAME}${NOCOLOR}" >&2
  fi
done