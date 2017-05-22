#TODO: re-enable nvidia support optionally.
#FROM nvidia-gazebo-ros:latest
FROM gazebo-ros:latest
USER root

ARG ROS_DISTRO_BUILD_TIME

# Install the ariac package
RUN apt-get update && apt-get install -y \
        ros-${ROS_DISTRO_BUILD_TIME}-ros-core \
        ros-${ROS_DISTRO_BUILD_TIME}-ros-base \
        ros-${ROS_DISTRO_BUILD_TIME}-catkin \
        ros-${ROS_DISTRO_BUILD_TIME}-ros-controllers \
        ariac \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Needed to use killall
RUN apt-get update && apt-get install -y \
        psmisc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# setup entrypoint
COPY ./ariac_entrypoint.sh /
COPY ./run_ariac_task.sh /

ENTRYPOINT ["/ariac_entrypoint.sh"]
