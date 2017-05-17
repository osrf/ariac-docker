#!/usr/bin/env bash

. ~/helloworld_ws/devel/setup.bash

# Run the example node
echo "Waiting for ROS master"
until rostopic list ; do sleep 1; done

sleep 10

echo "Running ARIAC example node"
rosrun ariac_example ariac_example_node
