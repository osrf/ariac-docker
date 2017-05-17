#!/usr/bin/env bash

. /opt/ros/$ROS_DISTRO/setup.bash
rosdep init
rosdep update

apt-get update
apt-get install -y wget

# Follow tutorial: http://wiki.ros.org/ariac/Tutorials/HelloWorld
mkdir -p ~/helloworld_ws/src/ariac_example
cd ~/helloworld_ws/src/ariac_example
wget https://bitbucket.org/osrf/ariac/raw/master/ariac_example/package.xml 
wget https://bitbucket.org/osrf/ariac/raw/no_catkin_python_setup/ariac_example/CMakeLists.txt

mkdir -p ~/helloworld_ws/src/ariac_example/config
cd ~/helloworld_ws/src/ariac_example/config
wget https://bitbucket.org/osrf/ariac/raw/master/ariac_example/config/sample_gear_conf.yaml

mkdir -p ~/helloworld_ws/src/ariac_example/src
cd ~/helloworld_ws/src/ariac_example/src
wget https://bitbucket.org/osrf/ariac/raw/master/ariac_example/src/ariac_example_node.cpp

cd ~/helloworld_ws
catkin_make
