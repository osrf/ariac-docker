#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

COMP_CONFIGS_DIR=${DIR}/comp_configs/

LIST_OF_TEAMS="example_team example_team2"

for TEAM_NAME in ${LIST_OF_TEAMS}; do
  echo "Running team: ${TEAM_NAME}"
  ./run_all_trials.bash "${TEAM_NAME}"
done
