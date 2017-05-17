#!/usr/bin/env bash

TEAM_NAME=$1

#TODO: get list of trials automatically
declare -a TRIAL_NAMES=("example_trial1" "example_trial2")
for TRIAL_NAME in ${TRIAL_NAMES[@]}; do
  echo "Running trial: ${TRIAL_NAME}"
  ./run_trial.bash ${TEAM_NAME} ${TRIAL_NAME}
done
