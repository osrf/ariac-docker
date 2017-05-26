#!/usr/bin/env bash

set -x

DOCKER_ARGS=""
# Uncoment this line to rebuild without cache
# TODO: expose this as an argument
#DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TEAM_NAME=$1
TEAM_CONFIG_DIR=${DIR}/../${TEAM_NAME}

# TODO: pass the path of the team's scripts as a parameter of the Dockerfile,
# instead of copying them temporarily so they always have the same location.
echo "Copying team scripts temporarily"
cp ${TEAM_CONFIG_DIR}/build_team_system.bash ${DIR}/ariac-competitor/build_team_system.bash
cp ${TEAM_CONFIG_DIR}/run_team_system.bash ${DIR}/ariac-competitor/run_team_system.bash

docker build ${DOCKER_ARGS} -t ariac-competitor-clean:latest ${DIR}/ariac-competitor-clean
docker build ${DOCKER_ARGS} -t ariac-competitor:latest ${DIR}/ariac-competitor

echo "Removing temporary team scripts"
rm ${DIR}/ariac-competitor/build_team_system.bash
rm ${DIR}/ariac-competitor/run_team_system.bash
