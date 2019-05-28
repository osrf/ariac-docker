FROM gazebo-ros-melodic:latest
USER root


# Install the ariac package
RUN apt-get update && apt-get install -y \
        ros-melodic-ros-controllers \
        ros-melodic-robot-state-publisher \
        ariac3 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Needed to use killall
RUN apt-get update && apt-get install -y \
        psmisc \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Need to install a specific version of gazebo_ros_pkgs
# 1. Remove official packages
RUN export GZ_VERSION=9 && \
    dpkg -r --force-depends ros-melodic-gazebo${GZ_VERSION}-ros-pkgs \
                            ros-melodic-gazebo${GZ_VERSION}-ros \
                            ros-melodic-gazebo${GZ_VERSION}-plugins \
                            ros-melodic-gazebo${GZ_VERSION}-msgs \
                            ros-melodic-gazebo${GZ_VERSION}-ros-control

# 2. Build the version from source
RUN mkdir -p /tmp/ros_ws/src
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd /tmp/ros_ws/src && \
                  catkin_init_workspace"
RUN git clone \
      https://github.com/osrf/ariac-gazebo_ros_pkgs.git /tmp/ros_ws/src/gazebo_ros_pkgs \
      -b ariac-network-melodic
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && \
                  cd /tmp/ros_ws/ && \
                  catkin_make -DCMAKE_INSTALL_PREFIX=/opt/ros/melodic -j2 install "

# setup entrypoint
COPY ./ariac_entrypoint.sh /
COPY ./run_ariac_task.sh /

USER $USERNAME
ENTRYPOINT ["/ariac_entrypoint.sh"]
