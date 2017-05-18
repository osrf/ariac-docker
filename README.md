# ARIAC Finals

This repository contains the setup that will be used to automatically evaluate teams' submission for the Agile Robotics for Industrial Automation Competition (ARIAC) hosted by the National Institute of Standards and Technology (NIST).
For full details on the competition Finals, please see https://bitbucket.org/osrf/ariac/wiki/finals

## Getting the code

Clone this code repository locally:

```
git clone https://github.com/osrf/ariac-docker
cd ariac-docker
```

## Preparing the workspace

Team configuration files must be put into a folder with the name of the team.

We have provided an example submission in this repository.
You should see that there is a directory called `example_team` that has the following configuration files in it:

```
build_team_system.bash  run_team_system.bash    team_config.yaml
```

Together these files constitute a submission.
The files are explained at https://bitbucket.org/osrf/ariac/wiki/finals

## Preparing the ARIAC system

To prepare the ARIAC competition system (but not run it), call:

```
./prepare_ariac_system.bash
```

This will build a Docker image of the competition server, ready to be launched later.

## Preparing your team's system

To prepare your team's system (but not run it), call:

```
./prepare_team_system.bash example_team

# For your team you will run:
# ./prepare_team_system.bash <your_team_name>
```

This will build a Docker image of your team's system, ready to be launched with the ARIAC competition server.

## Running a single trial

To run a trial (in this case the trial called `example_trial1`), call:

```
./run_trial.bash example_team example_trial1

# For your team you will run:
# ./run_trial.bash <your_team_name> <trial_name>
```

This will instantiate Docker "containers" of the images that we prepared earlier: one for the ARIAC competition, and one for your team's system.
The competition will be started using the competition configuration file associated with the trial name, and the user configuration file associated with your team name.

Once the trial has finished (because your system completed the trial, because you made a call to the `/ariac/end_competition` service, or because time ran out), the logs from the trial will be available in the `logs` directory that has now been created locally.

## Playing back the simulation

To play-back a competition log file, you must have ARIAC installed on your machine, and then you can call:

```
roslaunch osrf_gear gear_playback.launch state_log_path:=`pwd`/logs/example_team/example_trial1/gazebo/state.log
```
