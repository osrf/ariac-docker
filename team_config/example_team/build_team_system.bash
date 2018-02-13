#!/usr/bin/env bash

# Prepare ROS
. /opt/ros/${ROS_DISTRO}/setup.bash

# Install the necessary dependencies for getting the team's source code
# Note: there is no need to use `sudo`.
apt-get update
apt-get install -y wget unzip

# Create a catkin workspace
mkdir -p ~/my_team_ws/src

# Fetch the source code for our team's code
cd ~/my_team_ws/src
wget https://bitbucket.org/osrf/ariac_team_example/get/master.zip
unzip master.zip

cd ~/my_team_ws
catkin_make install