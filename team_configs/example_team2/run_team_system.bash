#!/usr/bin/env bash

. ~/my_team_ws/install/setup.bash

# Run the example node
echo "Launching ARIAC example nodes for example_team2"
roslaunch ariac_team_example example_nodes.launch
