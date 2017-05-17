FROM nvidia-gazebo-ros:latest
USER root

# Install the ariac package
RUN apt-get update && apt-get install -y \
        ros-indigo-ros-core \
        ros-indigo-ros-base \
        ros-indigo-catkin \
        ros-indigo-ros-controllers \
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
COPY ../run_ariac_.sh /

ENTRYPOINT ["/ariac_entrypoint.sh"]
