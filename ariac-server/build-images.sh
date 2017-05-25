DOCKER_ARGS=""
# Uncoment this line to rebuild without cache
#DOCKER_ARGS="--no-cache"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

USERID=`id -u $USER`
docker build ${DOCKER_ARGS} --build-arg userid=$USERID -t gazebo:latest $DIR/gazebo
docker build ${DOCKER_ARGS} -t gazebo-ros:latest $DIR/gazebo-ros
# TODO: re-enable nvidia support optionally.
#docker build ${DOCKER_ARGS} -t nvidia-gazebo-ros:latest $DIR/nvidia-gazebo-ros
docker build ${DOCKER_ARGS} -t ariac-server:latest $DIR/ariac-server
