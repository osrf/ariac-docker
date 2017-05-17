#!/usr/bin/env bash

# This will pull some files to setup an "example" ARIAC team

GIST_URL=https://gist.githubusercontent.com/dhood/f5314c070968f2531c39ca8aebff1e6a
GIST_VER=43a2f2a880a07af00b3dbd0e234877870e9a2cef

mkdir example_team && cd example_team
wget ${GIST_URL}/raw/${GIST_VER}/build_team_system.bash
wget ${GIST_URL}/raw/${GIST_VER}/run_team_system.bash
wget ${GIST_URL}/raw/${GIST_VER}/team_config.yaml
