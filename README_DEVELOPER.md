## Releasing a new version of ariac2 Docker images.

1. Build the base Docker images.

The most recent version of packages will be installed from `apt`.
Packages installed from `apt` include:
1. `ariac2`
1. `gazebo8`
1. ROS packages except those in `gazebo_ros_pkgs`

The `gazebo_ros_pkgs` metapackage is built from source using [this branch specific to ARIAC](https://github.com/ros-simulation/gazebo_ros_pkgs/tree/ariac-network-kinetic).

```
./prepare_ariac_system.bash kinetic
```

1. Test using local images.

Replace references to `ariac/ariac2-*:latest` images with the local image name, where images are being used for (1) building team images and (2) running trials.

That is:
- `ariac/ariac2-competitor-base-${ROS_DISTRO_BUILD_TIME}:latest` -> `ariac-competitor-base-${ROS_DISTRO_BUILD_TIME}` in `ariac-competitior/build_competitor_image.bash`
- `ariac/ariac2-server-${ROS_DISTRO}:latest` -> `ariac-server-${ROS_DISTRO}` in `run_trial.bash`

```
./prepare_team_system.bash example_team
./run_trial.bash example_team sample
```

Confirm the ARIAC version running in the container is correct:
```
docker exec -it ariac-server-system /bin/bash
dpkg -s ariac2
```

1. Push the images to Dockerhub.

Configure Dockerhub credentials, then:

```
./push_dockerhub_images.bash <ariac_version> <gazebo_version
# e.g.:
# ./push_dockerhub_images.bash ariac2.1.4 gazebo_8.4
```

This will also update the `lastest` tag on Dockerhub images.
