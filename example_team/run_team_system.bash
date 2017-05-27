#!/usr/bin/env bash

. ~/my_team_ws/install/setup.bash

# Run the example node
echo "Launching ARIAC example nodes"
roslaunch ariac_team_example example_nodes.launch
