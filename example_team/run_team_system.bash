#!/usr/bin/env bash

. ~/helloworld_ws/devel/setup.bash

# Run the example node
# TODO: do not start team's system until we know that we can communicate with the server.
# This could be done by having a wrapper script that only calls into this script when appropriate.
echo "Waiting for ROS master"
until rostopic list ; do sleep 1; done

sleep 10

# Run the example node
echo "Running ARIAC example node"
rosrun ariac_example ariac_example_node
