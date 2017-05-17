#!/bin/bash
set -e

# first, execute overriden entrypoint from gazebo
source "/usr/share/gazebo/setup.sh"

# setup ros environment. Ignore redifiniton of ROS_DISTRO
source "/opt/ros/indigo/setup.bash" > /dev/null

# setup ariac environment
source "/opt/ros/indigo/etc/catkin/profile.d/99_osrf_gear_setup.sh"
echo "ariac entrypoint executed"

# run gear
export GAZEBO_IP=127.0.0.1
export GAZEBO_IP_WHITE_LIST=127.0.0.1
rosrun osrf_gear gear.py --verbose -f `catkin_find --share osrf_gear`/config/qual3b.yaml `catkin_find --share osrf_gear`/config/sample_user_config.yaml

exec "$@"
