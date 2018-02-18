#!/usr/bin/env bash

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

trial_config_DIR=${DIR}/trial_config/

LIST_OF_TEAMS="example_team example_team2"

for TEAM_NAME in ${LIST_OF_TEAMS}; do
  ./run_all_trials.bash "${TEAM_NAME}"
done
