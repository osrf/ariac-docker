#!/bin/bash -x
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Preparing the ARIAC competition setup"

${DIR}/ariac-server/build-images.sh
${DIR}/ariac-competitor/build_competitor_base_image.bash
