FROM osrf/ros:indigo-desktop-full

USER root

# install bootstrap tools
RUN apt-get update && apt-get install --no-install-recommends -y \
    python-rosdep \
    python-rosinstall \
    python-vcstools \
    wget \
    && rm -rf /var/lib/apt/lists/*
RUN wget http://packages.osrfoundation.org/gazebo.key -O - | sudo apt-key add -
RUN echo "deb http://packages.osrfoundation.org/gazebo/ubuntu-stable `lsb_release -cs` main" > /etc/apt/sources.list.d/gazebo-stable.list

# Install the ariac package
RUN apt-get update && apt-get install -y \
        ros-indigo-ros-core \
        ros-indigo-ros-base \
        ros-indigo-catkin \
        ros-indigo-ros-controllers \
        ariac \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a new user called ariac-user and give them sudo priviledges.
ENV USERNAME ariac-user
RUN adduser --gecos "Development User" --disabled-password $USERNAME
RUN adduser $USERNAME sudo
WORKDIR /home/$USERNAME

# setup entrypoint
COPY ./build_team_system.bash /
RUN chmod 755 /build_team_system.bash
COPY ./run_team_system.bash /
RUN chmod 755 /run_team_system.bash
COPY ./run_team_system_with_delay.bash /
RUN chmod 755 /run_team_system_with_delay.bash

RUN /build_team_system.bash
ENTRYPOINT ["/run_team_system_with_delay.bash"]
