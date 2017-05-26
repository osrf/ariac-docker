#!/usr/bin/env bash

echo "Waiting for ROS master"
. /opt/ros/indigo/setup.bash
until rostopic list ; do sleep 1; done

# Wait for the ARIAC server to come up
sleep 10

# Run the team's system
echo "Running team system"
/run_team_system.bash
