#!/bin/bash -x
set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "Preparing the ARIAC competition setup"

ROS_DISTRO_TO_BUILD=${1}

if [[ -z ${ROS_DISTRO_TO_BUILD} ]]; then
  echo " - No ROS distributions specified as first arg, assumming indigo on trusty"
  sleep 3
  ROS_DISTRO_TO_BUILD="indigo"
fi

${DIR}/ariac-server/build-images.sh ${ROS_DISTRO_TO_BUILD}
${DIR}/ariac-competitor/build_competitor_base_image.bash ${ROS_DISTRO_TO_BUILD}
