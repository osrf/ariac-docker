#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEAM_NAME=${1}

if [[ $# -lt 1 ]]; then
  echo "$0 <team-image-dir-name>"
  exit 1
fi

if [[ ! -d team_configs/${TEAM_NAME} ]]; then
  echo "Can not find team directory in 'team_configs' directory: ${TEAM_NAME}"
  exit 1
fi

echo "Preparing the team system setup for team ${TEAM_NAME}"
if [[ $# -lt 1 ]]; then
  echo "$0 "
  exit 1
fi

${DIR}/ariac-competitor/build_competitor_image.bash ${TEAM_NAME}
