#!/usr/bin/env bash

DOCKER_ARGS=""
# Uncoment this line to rebuild without cache
#DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEAM_NAME=$1
TEAM_CONFIG_DIR=${DIR}/../${TEAM_NAME}

echo "Copying team scripts temporarily"
cp ${TEAM_CONFIG_DIR}/build_team_system.bash ${DIR}/build_team_system.bash
cp ${TEAM_CONFIG_DIR}/run_team_system.bash ${DIR}/run_team_system.bash

docker build ${DOCKER_ARGS} -t ariac-competitor ${DIR}

echo "Removing temporary team scripts"
rm ${DIR}/build_team_system.bash
rm ${DIR}/run_team_system.bash
