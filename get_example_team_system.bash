#!/usr/bin/env bash

# This will pull some files to setup an "example" ARIAC team

GIST_URL=https://gist.githubusercontent.com/dhood/f5314c070968f2531c39ca8aebff1e6a
GIST_VER=4e56174c4c2bccb9ff3daada6887d97ff02cf541

mkdir example_team && cd example_team
wget ${GIST_URL}/raw/${GIST_VER}/build_team_system.bash
wget ${GIST_URL}/raw/${GIST_VER}/run_team_system.bash
wget ${GIST_URL}/raw/${GIST_VER}/team_config.yaml
