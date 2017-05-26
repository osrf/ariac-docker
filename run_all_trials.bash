#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEAM_NAME=$1

COMP_CONFIGS_DIR=${DIR}/comp_configs/

# Get the available trials from the config directory
get_list_of_trials()
{
  yaml_files=$(ls ${COMP_CONFIGS_DIR}/*.yaml)

  for f in $(ls ${COMP_CONFIGS_DIR}/*.yaml); do
    f=${f##*/}
    f=${f//.yaml}
    all_names="${all_names} ${f}"
  done

  echo $all_names
}

for TRIAL_NAME in $(get_list_of_trials); do
  echo "Running trial: ${TRIAL_NAME}"
  ./run_trial.bash "${TEAM_NAME}" "${TRIAL_NAME}"
done
