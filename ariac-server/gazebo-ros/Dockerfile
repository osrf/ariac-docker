FROM gazebo-melodic:latest
# This image extends from nvidia-gazebo image to also provide ROS

USER root

# ----------------------------------------------------------------------------------
# Instructions derived from https://github.com/osrf/docker_images/tree/master/ros
# ----------------------------------------------------------------------------------
# setup ROS keys
RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys 421C365BD9FF1F717815A3895523BAEEB01FA116
# setup sources.list
RUN echo "deb http://packages.ros.org/ros/ubuntu bionic main" > /etc/apt/sources.list.d/ros-latest.list
# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    && rm -rf /var/lib/apt/lists/*

# bootstrap rosdep
RUN rosdep init \
    && rosdep update

# install ros packages
RUN apt-get update && apt-get install -y \
    ros-melodic-ros-core \
    ros-melodic-ros-base \
	&& apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ros_entrypoint.sh /
RUN chmod 755 /ros_entrypoint.sh

USER $USERNAME

ENTRYPOINT ["/ros_entrypoint.sh"]
CMD ["bash"]
# ----------------------------------------------------------------------------------
