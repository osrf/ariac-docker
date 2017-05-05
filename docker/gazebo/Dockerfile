FROM gazebo:gzserver7

# This image extends from official gzserver7 image to add a 
# gazebo user and automatically download gazebo models.

# setup environment
ENV DEBIAN_FRONTEND noninteractive
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

# Install bootstrap tools
#     sudo \
RUN apt-get update && apt-get install --no-install-recommends -y \
    bash-completion \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Create a new user called ariac. Note: we don't add him to the sudo group
ENV USERNAME ariac
RUN adduser --gecos "Development User" --disabled-password $USERNAME
RUN echo "export QT_X11_NO_MITSHM=1" >> /home/$USERNAME/.bashrc

USER $USERNAME
WORKDIR /home/$USERNAME

# Get gazebo models by calling wget here
# Do it early since it's big
RUN wget -P /tmp/ https://bitbucket.org/osrf/gazebo_models/get/default.tar.gz \
 && mkdir -p $HOME/.gazebo/models \
 && tar -xvf /tmp/default.tar.gz -C $HOME/.gazebo/models --strip 1 \
 && rm /tmp/default.tar.gz
