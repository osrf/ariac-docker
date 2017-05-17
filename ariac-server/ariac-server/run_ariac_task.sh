#!/bin/bash

# run_ariac_task.sh: A shell script to execute one ARIAC task.
# E.g.: ./run_ariac_task.sh `catkin_find --share osrf_gear`/config/qual3a.yaml
#  `catkin_find --share osrf_gear`/config/sample_user_config.yaml
#  /tmp/team_foo/finalA/1/

set -e

# Constants.
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NOCOLOR='\033[0m'

# Define usage function.
usage()
{
  echo "Usage: $0 <task.yaml> <user.yaml> <dst_folder>"
  exit 1
}

# Wait until the /ariac/competition_state returns "data: done".
# At this point the task is over.
wait_until_competition_ends()
{
  echo -n "Waiting for task termination..."
  OUTPUT=`rostopic echo -n 1 /ariac/competition_state 2>/dev/null`
  until [[ $OUTPUT == *"data: done"* ]]
  do
    OUTPUT=`rostopic echo -n 1 /ariac/competition_state 2>/dev/null`
    sleep 1
  done
  echo -e "${GREEN}OK${NOCOLOR}"
}

# Call usage() function if arguments not supplied.
[[ $# -ne 3 ]] && usage

TASK_CONFIG=$1
USER_CONFIG=$2
DST_FOLDER=$3

# Create a directory for the Gazebo log and the score file.
if [ -d "$DST_FOLDER" ]; then
  echo -e "${YELLOW}Wrn: Destination folder already exists. Data might be"\
          "overwritten${NOCOLOR}"
fi
mkdir -p $DST_FOLDER

echo -n "Running ARIAC task..."

# Run the task redirecting stdout and stderr.
rosrun osrf_gear gear.py -f $1 $2 > $DST_FOLDER/output 2>&1 &

echo -e "${GREEN}OK${NOCOLOR}"

# Wait until the task ends.
wait_until_competition_ends

echo -n "Terminating Gazebo..."

# Terminate Gazebo.
killall -w gzserver

echo -e "${GREEN}OK${NOCOLOR}"

# Copy log files.
echo -n "Copying logs into [$DST_FOLDER]..."
cp --recursive --dereference ~/.ariac/log/* $DST_FOLDER

echo -e "${GREEN}OK${NOCOLOR}"
