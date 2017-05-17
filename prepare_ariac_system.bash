#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Preparing the ARIAC competition setup"

${DIR}/ariac-server/build-images.sh
